const path = require('path');
const glob = require("glob");
const WebpackAssetsManifest = require('webpack-assets-manifest');
const CopyWebpackPlugin = require("copy-webpack-plugin");
const TerserJSPlugin = require('terser-webpack-plugin');
const RemovePlugin = require('remove-files-webpack-plugin');
const staticPath = "src/main/webapp/resources";
const exportPath = "src/main/webapp/dist";
const files = {};

const config = {
    mode: 'production',

    entry: glob.sync("./" + staticPath + "/**/!(library)/*.js").reduce((acc, item) => {
        const location = item.indexOf(staticPath) + (staticPath + "/js/").length;
        let keyPath = item.substring(location, item.length);
        // name : path.parse(item).base
        keyPath = keyPath.replaceAll(".js", "");
        acc[keyPath] = item;
        return acc
    }, {}),

    output: {
        path: path.resolve(__dirname, exportPath + '/js'),
        filename: '[name].[chunkhash].bundle.js'
    },

    module: {},

    optimization: {
        minimize: true,
        minimizer: [
            new TerserJSPlugin({ extractComments: false })
        ]
    },

    plugins: [
        new RemovePlugin({
            before: {
                include: [
                    exportPath,
                    'src/main/resources/static/asset-manifest.json'
                ]
            },
        }),
        new WebpackAssetsManifest({
            output: path.resolve(__dirname, 'src/main/resources/static/asset-manifest.json'),
            writeToDisk: true,
            customize: ({ key, value }) => {
                if (key.toLowerCase().endsWith('.js')){
                    key = "js/" + key;
                    value = "js/" + value;
                } else if(/.(png|jpe?g|gif|svg|css|woff|woff2)$/i.test(key.toLowerCase())){
                    key = key.substring('../'.length, key.length);
                    value = value.substring('../'.length, value.length);
                }

                return { key, value };
            },
        }),
        new CopyWebpackPlugin({
            patterns: [
                {
                    from: path.resolve(__dirname, 'src/main/webapp/resources/*/library/*.(js|css)'),
                    to({ context, absoluteFilename }) {
                        return getRealPath(absoluteFilename);
                    },
                },
                {
                    from: path.resolve(__dirname, 'src/main/webapp/resources/css/**/*.css'),
                    to({ context, absoluteFilename }) {
                        return getRealPath(absoluteFilename);
                    },
                    transform: {
                        transformer(content, absoluteFrom) {
                            const css = Buffer.from(content, 'utf8');
                            let strCss = css.toString();
                            for(const key in files) {
                                strCss = strCss.replaceAll(key, files[key]);
                            }

                            return new Buffer.from(strCss);
                        },
                    },
                    globOptions: {
                        dot: true,
                        gitignore: true,
                        ignore: ["**/library/*.css"],
                    },
                },
                {
                    from: path.resolve(__dirname, 'src/main/webapp/resources/(images|fonts)/**'),
                    to({ context, absoluteFilename }) {
                        const position = absoluteFilename.indexOf(staticPath) + staticPath.length;
                        let realPath = absoluteFilename.substring(position, absoluteFilename.length);

                        const fileName = absoluteFilename.substring(absoluteFilename.lastIndexOf('/') + 1, absoluteFilename.length);
                        const convertName = fileName.substring(0, fileName.indexOf(".") + 1) + new Date().getTime() + fileName.substring(fileName.indexOf("."), fileName.length);
                        files[fileName] = convertName;
                        return path.resolve(__dirname, exportPath + realPath.replaceAll(fileName, '') + convertName);
                    },
                },
            ]
        })
    ],
}

function getRealPath(absoluteFilename){
    const position = absoluteFilename.indexOf(staticPath) + staticPath.length;
    let realPath = absoluteFilename.substring(position, absoluteFilename.length);

    const fileName = absoluteFilename.substring(absoluteFilename.lastIndexOf('/') + 1, absoluteFilename.length);
    return path.resolve(__dirname, exportPath + realPath.replaceAll(fileName, '') + '[name].[contenthash][ext]');
}

module.exports = [
    config
];