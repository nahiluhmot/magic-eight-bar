var path = require('path');

module.exports = function(grunt) {
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-recess');
  grunt.loadNpmTasks('grunt-react');

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    copy: {
      reactSources: {
        files: [
          {
            expand: true,
            cwd: 'bower_components/react/',
            src: ['react.js','react.min.js'],
            dest: 'public/js/'
          }
        ]
      },
      smooth: {
        files: [
          {
            expand: true,
            cwd: 'bower_components/smooth-scroll/dist/js',
            src: '*.js',
            dest: 'public/js'
          }
        ]
      },
      jquery: {
        files: [
          {
            expand: true,
            cwd: 'bower_components/jquery/dist',
            src: '*.js',
            dest: 'public/js/'
          }
        ]
      },
      bootstrapJavaScript: {
        files: [
          {
            expand: true,
            cwd: 'bower_components/bootstrap/dist/js',
            src: '*.js',
            dest: 'public/js/'
          }
        ]
      },
      bootstrapCSS: {
        files: [
          {
            expand: true,
            cwd: 'bower_components/bootswatch/cosmo',
            src: '*.css',
            dest: 'public/css/'
          }
        ]
      },
      aviator: {
        files: [
          {
            expand: true,
            flatten: true,
            cwd: 'bower_components/aviator/',
            src: 'aviator.js',
            dest: 'public/js/',
          }
        ]
      },
      images: {
        files: [
          {
            expand: true,
            cwd: 'assets/img/',
            src: '*.jpg',
            dest: 'public/img/'
          }
        ]
      },
      reqwest: {
        files: [
          {
            expand: true,
            flatten: true,
            cwd: 'bower_components/reqwest/',
            src: ['reqwest.js', 'reqwest.min.js'],
            dest: 'public/js/',
          }
        ]
      },
      js: {
        files: [
          {
            expand: true,
            cwd: 'assets/js/',
            src: '**/*.js',
            dest: 'tmp/js/'
          }
        ]
      },
      index: {
        files: [
          {
            expand: true,
            cwd: 'views/',
            src: '**/*.html',
            dest: 'public/'
          }
        ]
      }
    },
    react: {
      jsx: {
        files: [
          {
            expand: true,
            cwd: 'assets/jsx',
            src: '**/*.jsx',
            dest: 'tmp/js',
            ext: '.js'
          }
        ]
      }
    },
    concat: {
      options: {
        // define a string to put between each file in the concatenated output
        separator: ''
      },
      js: {
        // the files to concatenate
        src: ['tmp/js/**/*.js'],
        // the location of the resulting JS file
        dest: 'public/js/<%= pkg.name %>.js'
      },
      css: {
        src: ['assets/less/**/*.less'],
        dest: 'tmp/less/<%= pkg.name %>.less'
      }
    },
    uglify: {
      js: {
        files: {
          'public/js/<%= pkg.name %>.min.js': ['<%= concat.js.dest %>'],
        }
      }
    },
    recess: {
      dist: {
        options: {
          compile: true
        },
        files: {
          'public/css/<%= pkg.name %>.css': 'tmp/less/*.less'
        }
      },
      min: {
        options: {
          compress: true
        },
        files: {
          'public/css/<%= pkg.name %>.min.css': 'public/css/<%= pkg.name %>.css',
        }
      }
    },
    watch: {
      all: {
        files: ['assets/js/**/*', 'assets/less/**/*', 'assets/jsx/**/*'],
        tasks: ['copy:js', 'react:jsx', 'concat:js', 'concat:css', 'uglify:js', 'recess:dist', 'recess:min', 'timestamp']
      }
    }
  });

  grunt.registerTask('timestamp', function() {
    grunt.log.subhead(Date());
  });

  grunt.registerTask('default', ['copy', 'react', 'concat', 'uglify', 'recess']);
};
