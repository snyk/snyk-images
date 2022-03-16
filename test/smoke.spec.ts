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

  if (process.env.IMAGE_TAG === 'driftctl') {
    it('ensure we have a proper driftctl binary installed in /bin/', async () => {
      const imageName = process.env.IMAGE_TAG;
      const { stdout, stderr } = await runContainer(
        imageName,
        '/bin/driftctl version',
      );

      expect(stdout).toContain('v0.23.1');
      expect(stderr).toBe('');
    });
  }
});
