import { runContainer } from './runContainer';
import { execSync } from 'child_process';

jest.setTimeout(1000 * 90);

describe('smoke tests', () => {
  it('can do `snyk version`', async () => {
    const imageName = process.env.IMAGE_TAG;
    const { stdout, stderr } = await runContainer(imageName, 'snyk version');
    const versionRegex = /1\.\d\d\d\d\.0/;
    expect(stdout).toMatch(versionRegex);
    expect(stderr).toBe('');
  });

  it('Entrypoint supports multiple args in a single arg (as it is provided by github actions)', async () => {
    const expected = execSync('ls -a -l -h').toString();
    const actual = execSync(
      __dirname + '/../docker-entrypoint.sh ls "-a -l" -h',
    ).toString();
    expect(actual).toEqual(expected);
  });

  it('Entrypoint supports spaces in arguments when complete cmd is wrapped in single quotes', async () => {
    const expected = execSync('date "+DATE: %Y-%m-%d"').toString();
    const actual = execSync(
      __dirname + '/../docker-entrypoint.sh \'date "+DATE: %Y-%m-%d"\'',
    ).toString();
    expect(actual).toEqual(expected);
  });

  it('Entrypoint adding JSON_OUTPUT', async () => {
    const actual = execSync(
      __dirname + '/../docker-entrypoint.sh echo -n "something else"',
      {
        env: {
          ...process.env,
          INPUT_COMMAND: 'test',
          INPUT_JSON: 'true',
        },
      },
    ).toString();
    expect(actual).toEqual('something else --json-file-output=snyk.json');
  });

  it('Entrypoint adding SARIF_OUTPUT', async () => {
    const actual = execSync(
      __dirname +
        '/../docker-entrypoint.sh \'echo -n "something else" --file=filename\'',
      {
        env: {
          ...process.env,
          SARIF_OUTPUT: '--sarif-file-output=snyk.sarif',
        },
      },
    ).toString();
    expect(actual).toEqual(
      'something else --file=filename --sarif-file-output=snyk.sarif',
    );
  });
});
