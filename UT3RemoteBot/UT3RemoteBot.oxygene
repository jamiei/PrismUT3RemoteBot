<Project DefaultTargets="Build" xmlns="http://schemas.microsoft.com/developer/msbuild/2003" ToolsVersion="3.5">
  <PropertyGroup>
    <RootNamespace>UT3RemoteBot</RootNamespace>
    <OutputType>Library</OutputType>
    <AssemblyName>UT3RemoteBot</AssemblyName>
    <AllowGlobals>False</AllowGlobals>
    <AllowLegacyOutParams>False</AllowLegacyOutParams>
    <AllowLegacyCreate>False</AllowLegacyCreate>
    <Configuration Condition="'$(Configuration)' == ''">Release</Configuration>
    <TargetFrameworkVersion>v3.5</TargetFrameworkVersion>
    <ProjectGuid>{CB0EF321-B0B5-4DCB-B858-719C45F96878}</ProjectGuid>
  </PropertyGroup>
  <PropertyGroup Condition=" '$(Configuration)' == 'Debug' ">
    <DefineConstants>DEBUG;TRACE;</DefineConstants>
    <OutputPath>.\bin\Debug</OutputPath>
    <GeneratePDB>True</GeneratePDB>
    <GenerateMDB>True</GenerateMDB>
  </PropertyGroup>
  <PropertyGroup Condition=" '$(Configuration)' == 'Release' ">
    <OutputPath>.\bin\Release</OutputPath>
    <EnableAsserts>False</EnableAsserts>
  </PropertyGroup>
  <ItemGroup>
    <Reference Include="mscorlib">
      <HintPath>$(Framework)\mscorlib.dll</HintPath>
    </Reference>
    <Reference Include="System">
      <HintPath>$(Framework)\System.dll</HintPath>
    </Reference>
    <Reference Include="System.Core">
      <HintPath>$(ProgramFiles)\Reference Assemblies\Microsoft\Framework\v3.5\System.Core.dll</HintPath>
    </Reference>
    <Reference Include="System.Data">
      <HintPath>$(Framework)\System.Data.dll</HintPath>
    </Reference>
    <Reference Include="System.Data.DataSetExtensions">
      <HintPath>$(ProgramFiles)\Reference Assemblies\Microsoft\Framework\v3.5\System.Data.DataSetExtensions.dll</HintPath>
    </Reference>
    <Reference Include="System.Drawing">
      <HintPath>$(Framework)\System.Drawing.dll</HintPath>
      <Private>True</Private>
    </Reference>
    <Reference Include="System.Windows.Forms">
      <HintPath>$(Framework)\System.Windows.Forms.dll</HintPath>
      <Private>True</Private>
    </Reference>
    <Reference Include="System.Xml">
      <HintPath>$(Framework)\System.Xml.dll</HintPath>
    </Reference>
    <Reference Include="System.Xml.Linq">
      <HintPath>$(ProgramFiles)\Reference Assemblies\Microsoft\Framework\v3.5\System.Xml.Linq.dll</HintPath>
    </Reference>
  </ItemGroup>
  <ItemGroup>
    <Compile Include="BotCommands.pas" />
    <Compile Include="BotEvents.pas" />
    <Compile Include="Communications\Enums.pas" />
    <Compile Include="Communications\Global.pas" />
    <Compile Include="Communications\Message.pas" />
    <Compile Include="Communications\MessageHandler.pas" />
    <Compile Include="Communications\MessageType.pas" />
    <Compile Include="Communications\UT3Connection.pas" />
    <Compile Include="GameState.pas" />
    <Compile Include="Properties\AssemblyInfo.pas" />
    <EmbeddedResource Include="Properties\Resources.resx">
      <Generator>ResXFileCodeGenerator</Generator>
    </EmbeddedResource>
    <Compile Include="Properties\Resources.Designer.pas" />
    <None Include="Properties\Settings.settings">
      <Generator>SettingsSingleFileGenerator</Generator>
    </None>
    <Compile Include="Properties\Settings.Designer.pas" />
    <Compile Include="UTBot.pas" />
    <Compile Include="UTItems\UTBotOppState.pas" />
    <Compile Include="UTItems\UTBotSelfState.pas" />
    <Compile Include="UTItems\UTBotState.pas" />
    <Compile Include="UTItems\UTIdentifier.pas" />
    <Compile Include="UTItems\UTItem.pas" />
    <Compile Include="UTItems\UTItemPoint.pas" />
    <Compile Include="UTItems\UTLevel.pas" />
    <Compile Include="UTItems\UTMap.pas" />
    <Compile Include="UTItems\UTNavPoint.pas" />
    <Compile Include="UTItems\UTObject.pas" />
    <Compile Include="UTItems\UTPlayerScore.pas" />
    <Compile Include="UTItems\UTPoint.pas" />
    <Compile Include="UTItems\UTVector.pas" />
  </ItemGroup>
  <Import Project="$(MSBuildExtensionsPath)\RemObjects Software\Oxygene\RemObjects.Oxygene.targets" />
</Project>