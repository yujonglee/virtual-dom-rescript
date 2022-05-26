@val @scope(("window", "document"))
external createDomElement: string => unit = "createElement"

type rec element<'props> = {
  tagName: string,
  props: 'props,
  children: array<element<'props>>,
  key: string,
  count: int,
}

type rec elementInput<'props> = {
  tagName: string,
  props: option<'props>,
  children: option<array<elementInput<'props>>>,
}

let rec createElement = (input: elementInput<'props>): element<'props> => {
  let {tagName, props, children} = input

  let props = Belt.Option.getWithDefault(props, Js.Obj.empty())
  let children = Belt.Option.getWithDefault(children, [])

  let hasKey = "key"->Js.Array.includes
  let key = if props->Js.Obj.keys->hasKey {
    props["key"]
  } else {
    Js.log(`Key is not provided for '${tagName}' element.`)
    "UNDEFINED"
  }

  {
    tagName: tagName,
    props: props,
    children: Js.Array.map(createElement, children),
    key: key,
    count: Js.Array.length(children), // TODO
  }
}

// TODO
let render = (el: element<'props>) => {
  let domElement = createDomElement(el.tagName)

  domElement
}
