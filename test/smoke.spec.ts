import { runContainer } from './runContainer';

jest.setTimeout(1000 * 90);

describe('smoke tests', () => {
  it('can do `snyk version`', async () => {
    const imageName = process.env.IMAGE_TAG;
    const { stdout, stderr } = await runContainer(imageName, 'snyk version');
    const versionRegex = /1\.\d\d\d\.0 \(standalone\)/;
    expect(stdout).toMatch(versionRegex);
    expect(stderr).toBe('');
  });
});
