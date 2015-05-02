# Capybara Remote Sample

![カピバラ](http://pds2.exblog.jp/pds/1/201208/05/64/f0134464_14162236.jpg "カピバラ")

## Description (What's this?)

Capybara + Rspec を Selenium で remote 実行するサンプルです。

PhantomJS(Poltergeist) での Ajax 関連のテストがつらかったので調べ物を兼ねて作りました。

Capybara Webkit は...セットアップからしてつらいので...。

## Tested Environments

* Client
    ScientificLinux 6.6
        Ruby 2.2.2 (rbenv)
            Rspec 3.2.0
            Capybara 2.4.4

* Remote Server
    Windows 8.1
        FireFox 37.0.2
        Internet Explorer11 11.0.9600.17728
        Google Chrome 42.0.2311.135
    Java 1.8.0_45
        Selenium RC Server 2.45.0

## Untested Environments

* Remote Server
    MacOS X
        Safari

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
$ java -jar selenium-server-standalone-2.45.0.jar
```

また、テスト対象のブラウザに応じて remote server 側で以下のセットアップが必要です。

* FireFox
    インストールするだけで OK.

* Google Chrome
    https://sites.google.com/a/chromium.org/chromedriver/downloads から ChromeDriver を download して PATH の通ったフォルダに入れます。

* Internet Explorer(Windows の場合のみ可)
    http://www.seleniumhq.org/download から 32bit 版 or 64bit 版の Internet Explorer Driver Server を download して PATH の通ったフォルダに入れます。  
    またテストの実行前に、remote server 側の IE のインターネット オプションの セキュリティ タブで全てのゾーンの保護モードの設定を無効にしておいてください。（そうしないとテストが必ず失敗します。）

* Safari(MacOS X の場合のみ可)
    http://www.seleniumhq.org/download から Safari Server を download して PATH の通ったディレクトリに入れます。

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
   |--support/
```

* spec/spec_helper.rb
    Rspec + Capybara の実行に必要な共通設定を入れたファイルです。  
    Rspec の実行時設定が必要な場合は、こちらでごにょごにょするとよいと思います。

* spec/features/sample_spec.rb
    Google さんにアクセスして title を検査するだけのテストのサンプルです。  
    テストを書いてこのディレクトリ配下に xxx_spec.rb の名前で保存すると rspec がひたすらテストを実行してくれます。

* spec/support/
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

```
$ RUN_REMOTE_HOST=192.168.1.1 RUN_REMOTE_BROWSER=ie bundle exec rspec
```

## License

MIT License.

[http://opensource.org/licenses/MIT]

## その他

カピバラもかわいいけどバクもよいよー。とてもよい。

[EOF]
