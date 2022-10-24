const esbuild = require('esbuild')
// app.css and app.js do not get moved into priv/static/assets when building

// require('fs').writeFileSync(require('path').join(process.cwd(),'derp'), 'asdf')
// cp ./assets/css/app.css ./priv/static/assets/
// cp ./assets/js/app.js ./priv/static/assets/
// cp ./assets/css/phoenix.css ./priv/static/assets/

// Decide which mode to proceed with
let mode = 'build'
process.argv.slice(2).forEach((arg) => {
  if (arg === '--watch') {
    mode = 'watch'
  } else if (arg === '--deploy') {
    mode = 'deploy'
  }
})

// Define esbuild options + extras for watch and deploy
let opts = {
  entryPoints: ['js/app.js', 'user-admin/bootstrap.tsx', 'todos/bootstrap.tsx'],
  bundle: true,
  logLevel: 'info',
  target: 'es2016',
  outdir: '../priv/static/assets'
}
if (mode === 'watch') {
  opts = {
    watch: true,
    sourcemap: 'inline',
    ...opts
  }
}
if (mode === 'deploy') {
  opts = {
    minify: true,
    ...opts
  }
}

// Start esbuild with previously defined options
// Stop the watcher when STDIN gets closed (no zombies please!)
esbuild.build(opts).then((result) => {
  if (mode === 'watch') {
    process.stdin.pipe(process.stdout)
    process.stdin.on('end', () => { result.stop() })
  }
}).catch((error) => {
  process.exit(1)
})
