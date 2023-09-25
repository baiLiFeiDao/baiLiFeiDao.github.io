# hexo-generator-category-enhance

[![Build Status](https://travis-ci.org/pmtao/hexo-generator-category-enhance.svg?branch=master)](https://travis-ci.org/pmtao/hexo-generator-category-enhance)  [![NPM version](https://badge.fury.io/js/hexo-generator-category-enhance.svg)](http://badge.fury.io/js/hexo-generator-category-enhance)

本仓库是 [Hexo] 程序的页面生成器插件，专用于辅助生成 Category 分类页面。
通过本插件，并结合 hexo 相应的布局模版，可以实现生成所有分类的页面，以及分类的主页面，并可以定制每页显示的文章数。

通过本插件，不再需要通过生成 page 的方式生成分类主页面（是的，这样并不友好，官方一直没有在生成器中正式支持，没办法只能再造一个 repo）。

Category generator for [Hexo].

## Installation

进入 hexo 主目录，执行以下命令：

Go to root directory of hexo, and execute:

``` bash
$ npm install hexo-generator-category-enhance --save
```

## Usage

再说一下怎么使用本插件。
在 hexo 配置文件 `_config.yml` 中添加如下项：

Add these items in hexo config file `_config.yml`:

```yaml
category_generator:
  per_page: 10
  enable_index_page: true
```
- **per_page**: 
  输入 0 表示不分页，输入正整数表示分页时每页显示的文章数。
  Posts displayed per page. (0 = disable pagination)
- **enable_index_page**: 
  选择是否生成分类主页面，true 表示生成，false 不生成。
  Choose to genarate category index page
  
如果需要生成分类主页面，还需要创建一个布局模版文件（像 [这个主题](https://github.com/pmtao/hexo-theme-typography) 中已经提供了，就不用再写了）。
在主题的 `layout` 目录下创建一个名称为：`category-index.jade` 的模版文件（文件后缀请根据模版引擎更改）。

If you set to generate category index page, you also need to creat a hexo templete file in theme directory  `layout` named: `category-index.jade` (please change file extension by other template engine). (false = don't generate)

## Acknowledgements

本站原始代码来源于以下仓库：[hexo-generator-category](https://github.com/hexojs/hexo-generator-category)，特此鸣谢。

## License

MIT

[Hexo]: http://hexo.io/