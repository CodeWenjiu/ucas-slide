{
  description = "UCAS presentation slide and homework templates for Typst, powered by Touying";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      # 仅供开发本仓库使用（nix develop）。
      #
      # 这里不提供任何“安装到全局包目录”的命令：那种做法会改动用户环境，
      # 卸载不干净还会影响其他项目。想在自己的文档里使用本模板，请把仓库作为
      # git 子模块（或直接拷贝）放进你的项目，再用相对路径导入：
      #
      #     #import "vendor/ucas-slide/lib.typ": *
      #
      # 包内素材一律用相对路径引用，因此放在任何位置都能正常工作，
      # 不需要环境变量，也不需要 Nix。
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            typst
          ];

          shellHook = ''
            # 以下改动只作用于本 devShell，不写入任何全局配置。
            #
            # template/ 里的导入写死了 `@preview/ucas-slide:<版本>`（因为这是
            # `typst init` 复制给终端的形态，必须如此）。为了让它在尚未发布到
            # Universe 时也能在本地编译验证，这里把本仓库挂成该包的本地副本。
            #
            # 布局为 <dir>/<namespace>/<name>/<version>，其中版本目录是指回
            # 仓库根的符号链接，所以本地改动立即生效。
            # Typst 先查 TYPST_PACKAGE_PATH、再查下载缓存，两者互不干扰，
            # touying / numbly 等 @preview 依赖仍会自动下载。
            _ucas_root="$PWD"
            while [ "$_ucas_root" != "/" ] && [ ! -f "$_ucas_root/typst.toml" ]; do
              _ucas_root="$(dirname "$_ucas_root")"
            done
            _ucas_version=$(sed -n 's/^version *= *"\(.*\)"/\1/p' "$_ucas_root/typst.toml" | head -n 1)
            export TYPST_PACKAGE_PATH="$_ucas_root/.typst-packages"
            mkdir -p "$TYPST_PACKAGE_PATH/preview/ucas-slide"
            ln -sfn "$_ucas_root" "$TYPST_PACKAGE_PATH/preview/ucas-slide/$_ucas_version"
            unset _ucas_root _ucas_version

            # nixpkgs 的开发环境默认为可复现构建而设 SOURCE_DATE_EPOCH=315532800
            # （1980-01-01），Typst 会把它当作“今天”，导致文档里的
            # datetime.today() 全显示成 1980 年。这里恢复真实时间。
            unset SOURCE_DATE_EPOCH
          '';
        };
      });
    };
}