import * as Docker from 'dockerode';
import * as stream from 'stream';
import * as path from 'path';

type Result = {
  stdout: string;
  stderr: string;
};

export async function runContainer(
  imageName: string,
  command: string,
  fixture?: string,
) {
  const myStdOutCaptureStream = new stream.Writable();
  let stdout = '';
  myStdOutCaptureStream._write = function (chunk, encoding, done) {
    stdout += chunk.toString();
    done();
  };

  const myStdErrCaptureStream = new stream.Writable();
  let stderr = '';
  myStdErrCaptureStream._write = function (chunk, encoding, done) {
    stderr += chunk.toString();
    done();
  };

  const binds: string[] = ['/var/run/docker.sock:/var/run/docker.sock'];

  if (fixture) {
    const fullFixturePath = path.resolve(__dirname, fixture);
    binds.push(`${fullFixturePath}:/app`);
  }

  const createOptions = {
    env: [`SNYK_TOKEN=${process.env.SNYK_TOKEN}`],
    HostConfig: {
      Binds: binds,
    },
    Tty: false, // splits stdout and stderr
  };

  const startOptions = {};

  const docker = new Docker();
  await docker.run(
    imageName,
    [command], // ex ['snyk test']
    [myStdOutCaptureStream, myStdErrCaptureStream],
    createOptions,
    startOptions,
  );

  return {
    stdout,
    stderr,
  };
}
