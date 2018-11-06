/**
 * bootstrapper
 *
 * @flow
 */

import p5 from 'p5'
import sketch from './'


/// code

export default function main() {
  p5.prototype.registerMethod('init', () => {
    require('p5/lib/addons/p5.dom')
  })

  new p5(sketch)
}


/// run

main()
