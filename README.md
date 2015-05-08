# Capybara Remote Sample

![カピバラ](http://pds2.exblog.jp/pds/1/201208/05/64/f0134464_14162236.jpg "カピバラ")

## Description (What's this?)

Capybara + Rspec を Selenium で remote 実行するサンプルです。

PhantomJS(Poltergeist) での Ajax 関連のテストが極めて不安定だったので、調べ物を兼ねて作りました。

Capybara Webkit はセットアップからしてつらいので動作は確認したもののあきらめています...。

でも結局あまりつらみには変わりないかも..。

## Tested Environments

* Client
    * ScientificLinux 6.6 (VirtualBox + Vagrant Guest)
        * Ruby 2.2.2 (rbenv)
            * Rspec 3.2.0
            * Capybara 2.4.4
    * MacOS X Yosemite 10.10.3
        * Ruby 2.2.2 (rbenv)
            * Rspec 3.2.0
            * Capybara 2.4.4
* Remote Server
    * Windows 8.1 64bit版
        * FireFox 37.0.2 64bit版
        * Internet Explorer Driver Server 2.45.0 32bit版
            * Internet Explorer11 11.0.9600.17728 64bit版
        * ChromeDriver 2.15 32bit版
            * Google Chrome 42.0.2311.135 64bit版
        * Java 1.8.0_45 64bit版
            * Selenium RC Server 2.45.0
    * MacOS X Yosemite 10.10.3
        * ChromeDriver 2.15 32bit版
            * Google Chrome 42.0.2311.135
        * SafariDriver 2.45.0
            * Safari 8.0.5(10600.5.17)
        * Java 1.8.0_05 64bit版
            * Selenium RC Server 2.45.0

## Usage

### Setup

git clone した先のディレクトリで bundle install を実行してください。

```
$ bundle install --path=vendor/bundle
```

### Run

普通に rspec を実行します。

```
$ bundle exec rspec
```

テスト実行の前には、事前に remote server 側で JRE or JDK 及び http://www.seleniumhq.org/download/ から Selenium Server (Selenium RC Server) を download して起動しておく必要があります。

```
> java -jar selenium-server-standalone-2.45.0.jar
```

Cygwin + Windows の環境などで、表示される文字列を UTF-8 にしたい場合は、以下の様に実行しておくとよいと思います。

```
$ java -Dfile.encoding=UTF-8 -jar selenium-server-standalone-2.45.0.jar
```

また、テスト対象のブラウザに応じて remote server 側で以下のセットアップが必要です。

* FireFox
    インストールするだけで OK.

* Google Chrome
    https://sites.google.com/a/chromium.org/chromedriver/downloads から ChromeDriver を download して PATH の通ったフォルダに入れます。

* Internet Explorer (Windows の場合のみ可)
    http://www.seleniumhq.org/download から 32bit 版の Internet Explorer Driver Server を download して PATH の通ったフォルダに入れます。64 bit 版の Driver は 32bit 版、64 bit 版の混在環境の影響で SendKeys 時に一文字あたり 5 秒かかるという不具合がある模様なので、現時点では使用しない方がよいと思います。（参考：[Why is Selenium InternetExplorerDriver Webdriver very slow in debug mode (visual studio 2010 and IE9)](http://stackoverflow.com/questions/8850211/why-is-selenium-internetexplorerdriver-webdriver-very-slow-in-debug-mode-visual)）  
    またテストの実行前に、remote server 側の IE のインターネット オプションの セキュリティ タブで全てのゾーンの保護モードの設定を有効または無効にしておいてください。（全てのゾーンの保護モードの設定を有効か無効かに揃えてください。）そうしないとテストが必ず失敗します。（参考：[Selenium (webDriver) と IE11の組み合わせについて](http://qiita.com/gluelan2013/items/6977cde545e2bcf08081)）

* Safari (MacOS X の場合のみ可)  
    http://www.seleniumhq.org/download から Safari Server を download して実行すると Safari の拡張機能としてインストールが行われます。

## Constitution

```
capybara-remote-sample/
|--.gitignore
|--.rspec
|--Gemfile
|--README.md
|--spec/
   |--features/
   |  |--sample_spec.rb
   |--spec_helper.rb
   |--supports/
      |--capybara_sample_helper.rb
      |--have_searched_result_in_google.rb
```

* spec/spec_helper.rb  
    Rspec + Capybara の実行に必要な共通設定を入れたファイルです。  
    Rspec の実行時設定が必要な場合は、こちらでごにょごにょするとよいと思います。

* spec/features/sample_spec.rb  
    Google さんにアクセスして title を検査するだけのテストと、Google さんにアクセスして Capybara で検索して検索に成功したかどうかを検査するだけのテストのサンプルです。  
    テストを書いてこのディレクトリ配下に xxx_spec.rb の名前で保存すると rspec がまとめてテストを実行してくれます。

* spec/supports/  
    Custom Matcher や共通で使う fill_in の設定などを入れておくディレクトリです。  
    ここに入った *.rb ファイルは rspec 実行時に自動で require されます。

## Setting

実行前に以下の環境変数を設定することでテストの挙動を変更できます。

* RUN_REMOTE_BROWSER  
    テスト対象のブラウザを指定します。既定値は firefox です。  
    ブラウザは firefox, chrome, ie, safari を指定できます。  
    設定がこれら以外の文字列の場合は firefox でテストを実行します。

* RUN_REMOTE_HOST  
    remote server のホスト名またはIPアドレスを指定します。既定値は localhost です。

* RUN_REMOTE_PORT  
    remote server のポート番号を指定します。既定値は 4444 です。

こんな感じで実行するとよいと思います。

```
$ RUN_REMOTE_BROWSER=ie RUN_REMOTE_HOST=192.168.1.1 bundle exec rspec
```

## Notes

* InternetExplorerDriver を IE11 環境で動作させる場合は、特殊なレジストリ・キーの設定が必要な模様です。詳細は [InternetExplorerDriver - selenium](https://code.google.com/p/selenium/wiki/InternetExplorerDriver) のページを参照してください。  
    IE11 は正式にはサポートされているわけではなさそうですが、手元の Windows8.1 環境との組み合わせでは、サンプルについて一応動作することを確認しています。

* Windows 2003 Server, 2008 Server で InternetExplorerDriver を動作させる場合は、事前に IE ESC の設定を解除してください。JavaScript が無効化されているため、テストに必ず失敗します。

## License

[MIT License](http://opensource.org/licenses/MIT "MIT License") です。

## 参考リンク

* [jnicklas/capybara - GitHub](https://github.com/jnicklas/capybara)

* [Documentation for jnicklas/capybara (master) Index](http://www.rubydoc.info/github/jnicklas/capybara/master/index)

* [InternetExplorerDriver - selenium](https://code.google.com/p/selenium/wiki/InternetExplorerDriver)

* [RSpec3 / Capybara / Capybara-Webkit チートシート - Rails Webook](http://ruby-rails.hatenadiary.com/entry/20150103/1420280252)

* [RSpecでカスタムマッチャを作る - Qiita](http://qiita.com/kozy4324/items/9a6530736be7e92954bc)

* [Capybara 2 にアップグレード - Qiita](http://qiita.com/quattro_4/items/64c5abdf86c7b40d40b1)

* [Capybara で within した場所や find したノードに枠を付けてくれるやつ作った - Thanks Driven Life](http://gongo.hatenablog.com/entry/2013/08/01/000958)

## その他

カピバラもかわいいけどバクもよい。マレーバクとてもよい。

![マレーバク](http://upload.wikimedia.org/wikipedia/commons/3/3e/Malayan_Tapir_001.jpg "マレーバク")
