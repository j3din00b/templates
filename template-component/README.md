# Convex Component Template

This is a Convex component, ready to be published on npm.

To create your own component:

1. Run `node rename.mjs` to rename everything to your component's name.
1. Write code in src/component for your component.
1. Write code in src/client for your thick client.
1. Write example usage in example/convex/example.ts.
1. Delete the text in this readme until `---` and flesh out the README.
1. Publish to npm with `npm run alpha` or `npm run release`.

To develop your component run a dev process in the example project.
For convenience, `npm run dev` will start both a file watcher to re-build
the component, as well as install, configure, and run the example project.

```
npm run dev
```

Modify the schema and index files in src/component/ to define your component.

Write a client for using this component in src/client/index.ts.

If you won't be adding frontend code (e.g. React components) to this
component you can delete the following:

- "prepack" and "postpack" scripts of package.json
- "./react" exports in package.json
- the "src/react/" directory
- the "node10stubs.mjs" file

If you will be adding frontend code, add a peer dependency on React in package.json.

### Component Directory structure

```
.
├── README.md           documentation of your component
├── package.json        component name, version number, other metadata
├── package-lock.json   Components are like libraries, package-lock.json
│                       is .gitignored and ignored by consumers.
├── src
│   ├── component/
│   │   ├── _generated/ Files here are generated for the component.
│   │   ├── convex.config.ts  Name your component here and use other components
│   │   ├── index.ts    Define functions here and in new files in this directory
│   │   └── schema.ts   schema specific to this component
│   ├── client/index.ts "Thick" client code goes here.
│   └── react/          Code intended to be used on the frontend goes here.
│       │               Your are free to delete this if this component
│       │               does not provide code.
│       └── index.ts
├── example/            example Convex app that uses this component
│   │                   Run 'npx convex dev' from here during development.
│   ├── package.json.ts Thick client code goes here.
│   └── convex/
│       ├── _generated/       Files here are generated for the example app.
│       ├── convex.config.ts  Imports and uses this component
│       ├── myFunctions.ts    Functions that use the component
│       └── schema.ts         Example app schema
└── dist/               Publishing artifacts will be created here.
```

### Structure of a Convex Component

A Convex components exposes the entry point convex.config.js. The on-disk
location of this file must be a directory containing implementation files. These
files should be compiled to ESM.

In addition to convex.config.js, a component typically exposes a client that
wraps communication with the component for use in the Convex
environment is typically exposed as a named export `MyComponentClient` or
`MyComponent` imported from the root package.

```
import { MyComponentClient } from "my-convex-component";
```

When frontend code is included it is typically published at a subpath:

```
import { helper } from "my-convex-component/react";
import { FrontendReactComponent } from "my-convex-component/react";
```

Frontend code should be compiled as CommonJS code as well as ESM and make use of
subpackage stubs (see next section).

If you do include frontend components, prefer peer dependencies to avoid using
more than one version of e.g. React.

### Support for Node10 module resolution

The [Metro](https://reactnative.dev/docs/metro) bundler for React Native
requires setting
[`resolver.unstable_enablePackageExports`](https://metrobundler.dev/docs/package-exports/)
in order to import code that lives in `dist/esm/react.js` from a path like
`my-convex-component/react`.

Authors of Convex component that provide frontend components are encouraged to
support these legacy "Node10-style" module resolution algorithms by generating
stub directories with special pre- and post-pack scripts.

---

# Convex Sharded Counter Component

[![npm version](https://badge.fury.io/js/@convex-dev%2Fsharded-counter.svg)](https://badge.fury.io/js/@convex-dev%2Fsharded-counter)

<!-- START: Include on https://convex.dev/components -->

- [ ] What is some compelling syntax as a hook?
- [ ] Why should you use this component?
- [ ] Links to Stack / other resources?

Found a bug? Feature request? [File it here](https://github.com/get-convex/sharded-counter/issues).

## Pre-requisite: Convex

You'll need an existing Convex project to use the component.
Convex is a hosted backend platform, including a database, serverless functions,
and a ton more you can learn about [here](https://docs.convex.dev/get-started).

Run `npm create convex` or follow any of the [quickstarts](https://docs.convex.dev/home) to set one up.

## Installation

Install the component package:

```ts
npm install @convex-dev/sharded-counter
```

Create a `convex.config.ts` file in your app's `convex/` folder and install the component by calling `use`:

```ts
// convex/convex.config.ts
import { defineApp } from "convex/server";
import shardedCounter from "@convex-dev/sharded-counter/convex.config";

const app = defineApp();
app.use(shardedCounter);

export default app;
```

## Usage

```ts
import { components } from "./_generated/api";
import { ShardedCounter } from "@convex-dev/sharded-counter";

const shardedCounter = new ShardedCounter(components.shardedCounter, {
  ...options,
});
```

See more example usage in [example.ts](./example/convex/example.ts).

Run the example with `npm run example`.
<!-- END: Include on https://convex.dev/components -->
