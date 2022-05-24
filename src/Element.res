@val @scope(("window", "document"))
external createDomElement: string => unit = "createElement"

type rec element<'props> = {
  tagName: string,
  props: 'props,
  children: array<element<'props>>,
  key: string,
  count: int,
}

type elementInput<'props> = {
  tagName: string,
  props: option<'props>,
  children: option<array<element<'props>>>,
}

let toInput = (el: element<'props>): elementInput<'props> => {
  let {tagName, props, children} = el

  {
    tagName: tagName,
    props: Some(props),
    children: Some(children),
  }
}

let rec createElement = (input: elementInput<'props>): element<'props> => {
  let {tagName, props, children} = input

  let props = Belt.Option.getWithDefault(props, Js.Obj.empty())
  let children = Belt.Option.getWithDefault(children, [])

  let createChild = c => toInput(c)->createElement

  {
    tagName: tagName,
    props: props,
    children: Js.Array.map(createChild, children),
    key: "", // TODO
    count: 1, // TODO
  }
}

// TODO
let render = (el: element<'props>) => {
  let domElement = createDomElement(el.tagName)

  domElement
}
