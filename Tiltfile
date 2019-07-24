k8s_yaml('Deployments/Dev.yml')
k8s_yaml('Deployments/Staging.yml')

custom_build(
  'ryanmeis.dev/resume_dev',
  'docker build --target build -t $EXPECTED_REF .',
  ['.'],
  disable_push=True,
  live_update = [
    sync('.', '/wd')
    ],
  entrypoint='hugo server -wDEF --bind=0.0.0.0'
)
k8s_resource('resume-page-dev', port_forwards='1313')

docker_build('ryanmeis.dev/resume', '.')
k8s_resource('resume', port_forwards='8080')
