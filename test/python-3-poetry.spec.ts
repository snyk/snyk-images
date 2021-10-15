import { runContainer } from './runContainer';

jest.setTimeout(1000 * 60);

it('can do `snyk test` on a poetry project', async () => {
  const imageName = 'python-3.8';
  const { stdout, stderr } = await runContainer(
    imageName,
    'snyk test',
    './fixtures/python-3-poetry',
  );

  expect(stdout).toContain('Testing /app...');
  expect(stdout).toContain('poetry-fixtures-project');
  expect(stdout).toContain(
    'Regular Expression Denial of Service (ReDoS) [Medium Severity][https://snyk.io/vuln/SNYK-PYTHON-JINJA2-1012994] in jinja2@2.11.2',
  );
  expect(stderr).toBe('');
});
