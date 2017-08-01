let
	babel = require('gulp-babel'),
	clean = require('gulp-clean'),
	env = require('gulp-environments'),
	errorHandler = require('gulp-error-handle'),
	exec = require('child_process').exec,
	gls = require('gulp-live-server'),
	gulp = require('gulp'),
	htmlmin = require('gulp-htmlmin'),
	outDir = env.production() ? './' : './dist/',
	runSequence = require('run-sequence'),
	sass = require('gulp-sass');

// очистка папки назначения
gulp.task('rm', () => gulp.src(`${outDir}/*`).pipe(clean()));

gulp.task('babel', () => gulp.src([
	'./app/generic/**/*.js',
	'./app/settings/**/*.js',
	'./app/Admin/**/*.js',
	'./app/Site/**/*.js',
	'./app.js',
	'./app/index.js'], {base: './'})

	.pipe(errorHandler())
	.pipe(babel({presets: ['es2015']}))
	.pipe(gulp.dest(outDir))
);

// копирование "статики"
gulp.task('copy', () => gulp.src(
	[
		'./app/**/*.html',
		'./app/**/*.hbs',
		'./app/**/*.json',
		'./app/assets/public/**',
		'.env',
	],

	{base: './'})
	.pipe(gulp.dest(outDir)));

gulp.task('htmlm', () => { // минификация html
	return gulp.src(`${outDir}/app/assets/views/**/*.html`)

		.pipe(env.production(htmlmin({
			collapseWhitespace           : true,
			decodeEntities               : true,
			minifyCSS                    : true,
			minifyJS                     : true,
			removeAttributeQuotes        : true,
			removeComments               : true,
			removeStyleLinkTypeAttributes: true,
		})))

		.pipe(gulp.dest(`${outDir}/app/assets/public`));
});

// инсталяция продакшен модулей для релизной сборки
gulp.task('prodmods', cb => {
	if(env.production())
		return gulp.src('./package.json')
			.pipe(errorHandler())
			.pipe(gulp.dest(outDir))
			.on('finish', () => {
				// инсталлируем только dependency пакеты в папку с билдом
				exec('npm i --only=prod', {cwd: outDir}, () => {
				});
			});
	else cb();
});

// отладочный сервер
gulp.task('srv', cb => {
	let srv = gls('app.js', {cwd: outDir});
	srv.start();

	// вьюхи|json
	gulp.watch(['./app/assets/views/**/*.html', './app/assets/views/**/*.hbs', './app/**/*.json'], e => {
		gulp.src(e.path, {base: './'})
			.pipe(gulp.dest(outDir))
			.pipe(srv.notify());
	});

	// *.js
	gulp.watch([
		'./app/generic/**/*.js',
		'./app/settings/**/*.js',
		'./app/Admin/**/*.js',
		'./app/Site/**/*.js',
		'./app.js',
		'./app/index.js'], e => {
		gulp.src(e.path, {base: './'})
			.pipe(errorHandler())
			.pipe(babel({presets: ['es2015']}))
			.pipe(gulp.dest(`${outDir}`))
			.on('finish', () => {
				srv.stop();
				srv.start();
				console.log('server restarted');
			});
	});

	// watch which json
	gulp.watch('./app/settings/*.json', e => {
		gulp.src(e.path, {base: './app/settings/'})
			.pipe(gulp.dest(`${outDir}/app/settings/`));
	});

	// css frontend
	gulp.watch('./app/assets/public/css/**/*.css', e => {
		gulp.src(e.path, {base: './app/assets/public/css'})
			.pipe(gulp.dest(`${outDir}/app/assets/public/css`));
	});

	// sass
	gulp.watch('./app/assets/public/sass/**/*.scss', ['sass'])
		.on('finish', () => {
			srv.stop();
			srv.start();
			console.log('server restarted');
		});

	// js frontend
	gulp.watch('./app/assets/public/js/**/*.js', e => {
		gulp.src(e.path, {base: './app/assets/public/js'})
			.pipe(gulp.dest(`${outDir}/app/assets/public/js`));
	});

	// SVG
	gulp.watch('./app/assets/public/**/*.svg', e => {
		gulp.src(e.path, {base: './'})
			.pipe(gulp.dest(`${outDir}`))
			.on('finish', () => {
				srv.stop();
				srv.start();
				console.log('server restarted');
			});
	});

	cb();
});

gulp.task('sass', () => {
	return gulp.src('./app/assets/public/sass/**/*.scss')
		.pipe(sass().on('error', sass.logError))
		.pipe(gulp.dest(`${outDir}/app/assets/public/css`))
});

gulp.task('dist', () => { runSequence('rm', 'babel', 'copy', 'htmlm', 'prodmods') });
gulp.task('default', () => { runSequence('rm', 'babel', 'copy', 'prodmods', 'srv', 'sass') });
