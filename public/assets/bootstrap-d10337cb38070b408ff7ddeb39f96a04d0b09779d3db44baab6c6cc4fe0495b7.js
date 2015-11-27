/* ===================================================
 * bootstrap-transition.js v2.2.2
 * http://twitter.github.com/bootstrap/javascript.html#transitions
 * ===================================================
 * Copyright 2012 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ========================================================== */
!function(t){"use strict";t(function(){t.support.transition=function(){var t=function(){var t,e=document.createElement("bootstrap"),i={WebkitTransition:"webkitTransitionEnd",MozTransition:"transitionend",OTransition:"oTransitionEnd otransitionend",transition:"transitionend"};for(t in i)if(void 0!==e.style[t])return i[t]}();return t&&{end:t}}()})}(window.jQuery),/* ==========================================================
 * bootstrap-alert.js v2.2.2
 * http://twitter.github.com/bootstrap/javascript.html#alerts
 * ==========================================================
 * Copyright 2012 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ========================================================== */
!function(t){"use strict";var e='[data-dismiss="alert"]',i=function(i){t(i).on("click",e,this.close)};i.prototype.close=function(e){function i(){o.trigger("closed").remove()}var o,n=t(this),s=n.attr("data-target");s||(s=n.attr("href"),s=s&&s.replace(/.*(?=#[^\s]*$)/,"")),o=t(s),e&&e.preventDefault(),o.length||(o=n.hasClass("alert")?n:n.parent()),o.trigger(e=t.Event("close")),e.isDefaultPrevented()||(o.removeClass("in"),t.support.transition&&o.hasClass("fade")?o.on(t.support.transition.end,i):i())};var o=t.fn.alert;t.fn.alert=function(e){return this.each(function(){var o=t(this),n=o.data("alert");n||o.data("alert",n=new i(this)),"string"==typeof e&&n[e].call(o)})},t.fn.alert.Constructor=i,t.fn.alert.noConflict=function(){return t.fn.alert=o,this},t(document).on("click.alert.data-api",e,i.prototype.close)}(window.jQuery),/* ============================================================
 * bootstrap-button.js v2.2.2
 * http://twitter.github.com/bootstrap/javascript.html#buttons
 * ============================================================
 * Copyright 2012 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ============================================================ */
!function(t){"use strict";var e=function(e,i){this.$element=t(e),this.options=t.extend({},t.fn.button.defaults,i)};e.prototype.setState=function(t){var e="disabled",i=this.$element,o=i.data(),n=i.is("input")?"val":"html";t+="Text",o.resetText||i.data("resetText",i[n]()),i[n](o[t]||this.options[t]),setTimeout(function(){"loadingText"==t?i.addClass(e).attr(e,e):i.removeClass(e).removeAttr(e)},0)},e.prototype.toggle=function(){var t=this.$element.closest('[data-toggle="buttons-radio"]');t&&t.find(".active").removeClass("active"),this.$element.toggleClass("active")};var i=t.fn.button;t.fn.button=function(i){return this.each(function(){var o=t(this),n=o.data("button"),s="object"==typeof i&&i;n||o.data("button",n=new e(this,s)),"toggle"==i?n.toggle():i&&n.setState(i)})},t.fn.button.defaults={loadingText:"loading..."},t.fn.button.Constructor=e,t.fn.button.noConflict=function(){return t.fn.button=i,this},t(document).on("click.button.data-api","[data-toggle^=button]",function(e){var i=t(e.target);i.hasClass("btn")||(i=i.closest(".btn")),i.button("toggle")})}(window.jQuery),/* ==========================================================
 * bootstrap-carousel.js v2.2.2
 * http://twitter.github.com/bootstrap/javascript.html#carousel
 * ==========================================================
 * Copyright 2012 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ========================================================== */
!function(t){"use strict";var e=function(e,i){this.$element=t(e),this.options=i,"hover"==this.options.pause&&this.$element.on("mouseenter",t.proxy(this.pause,this)).on("mouseleave",t.proxy(this.cycle,this))};e.prototype={cycle:function(e){return e||(this.paused=!1),this.options.interval&&!this.paused&&(this.interval=setInterval(t.proxy(this.next,this),this.options.interval)),this},to:function(e){var i=this.$element.find(".item.active"),o=i.parent().children(),n=o.index(i),s=this;if(!(e>o.length-1||0>e))return this.sliding?this.$element.one("slid",function(){s.to(e)}):n==e?this.pause().cycle():this.slide(e>n?"next":"prev",t(o[e]))},pause:function(e){return e||(this.paused=!0),this.$element.find(".next, .prev").length&&t.support.transition.end&&(this.$element.trigger(t.support.transition.end),this.cycle()),clearInterval(this.interval),this.interval=null,this},next:function(){return this.sliding?void 0:this.slide("next")},prev:function(){return this.sliding?void 0:this.slide("prev")},slide:function(e,i){var o,n=this.$element.find(".item.active"),s=i||n[e](),a=this.interval,r="next"==e?"left":"right",l="next"==e?"first":"last",h=this;if(this.sliding=!0,a&&this.pause(),s=s.length?s:this.$element.find(".item")[l](),o=t.Event("slide",{relatedTarget:s[0]}),!s.hasClass("active")){if(t.support.transition&&this.$element.hasClass("slide")){if(this.$element.trigger(o),o.isDefaultPrevented())return;s.addClass(e),s[0].offsetWidth,n.addClass(r),s.addClass(r),this.$element.one(t.support.transition.end,function(){s.removeClass([e,r].join(" ")).addClass("active"),n.removeClass(["active",r].join(" ")),h.sliding=!1,setTimeout(function(){h.$element.trigger("slid")},0)})}else{if(this.$element.trigger(o),o.isDefaultPrevented())return;n.removeClass("active"),s.addClass("active"),this.sliding=!1,this.$element.trigger("slid")}return a&&this.cycle(),this}}};var i=t.fn.carousel;t.fn.carousel=function(i){return this.each(function(){var o=t(this),n=o.data("carousel"),s=t.extend({},t.fn.carousel.defaults,"object"==typeof i&&i),a="string"==typeof i?i:s.slide;n||o.data("carousel",n=new e(this,s)),"number"==typeof i?n.to(i):a?n[a]():s.interval&&n.cycle()})},t.fn.carousel.defaults={interval:5e3,pause:"hover"},t.fn.carousel.Constructor=e,t.fn.carousel.noConflict=function(){return t.fn.carousel=i,this},t(document).on("click.carousel.data-api","[data-slide]",function(e){var i,o=t(this),n=t(o.attr("data-target")||(i=o.attr("href"))&&i.replace(/.*(?=#[^\s]+$)/,"")),s=t.extend({},n.data(),o.data());n.carousel(s),e.preventDefault()})}(window.jQuery),/* =============================================================
 * bootstrap-collapse.js v2.2.2
 * http://twitter.github.com/bootstrap/javascript.html#collapse
 * =============================================================
 * Copyright 2012 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ============================================================ */
!function(t){"use strict";var e=function(e,i){this.$element=t(e),this.options=t.extend({},t.fn.collapse.defaults,i),this.options.parent&&(this.$parent=t(this.options.parent)),this.options.toggle&&this.toggle()};e.prototype={constructor:e,dimension:function(){var t=this.$element.hasClass("width");return t?"width":"height"},show:function(){var e,i,o,n;if(!this.transitioning){if(e=this.dimension(),i=t.camelCase(["scroll",e].join("-")),o=this.$parent&&this.$parent.find("> .accordion-group > .in"),o&&o.length){if(n=o.data("collapse"),n&&n.transitioning)return;o.collapse("hide"),n||o.data("collapse",null)}this.$element[e](0),this.transition("addClass",t.Event("show"),"shown"),t.support.transition&&this.$element[e](this.$element[0][i])}},hide:function(){var e;this.transitioning||(e=this.dimension(),this.reset(this.$element[e]()),this.transition("removeClass",t.Event("hide"),"hidden"),this.$element[e](0))},reset:function(t){var e=this.dimension();return this.$element.removeClass("collapse")[e](t||"auto")[0].offsetWidth,this.$element[null!==t?"addClass":"removeClass"]("collapse"),this},transition:function(e,i,o){var n=this,s=function(){"show"==i.type&&n.reset(),n.transitioning=0,n.$element.trigger(o)};this.$element.trigger(i),i.isDefaultPrevented()||(this.transitioning=1,this.$element[e]("in"),t.support.transition&&this.$element.hasClass("collapse")?this.$element.one(t.support.transition.end,s):s())},toggle:function(){this[this.$element.hasClass("in")?"hide":"show"]()}};var i=t.fn.collapse;t.fn.collapse=function(i){return this.each(function(){var o=t(this),n=o.data("collapse"),s="object"==typeof i&&i;n||o.data("collapse",n=new e(this,s)),"string"==typeof i&&n[i]()})},t.fn.collapse.defaults={toggle:!0},t.fn.collapse.Constructor=e,t.fn.collapse.noConflict=function(){return t.fn.collapse=i,this},t(document).on("click.collapse.data-api","[data-toggle=collapse]",function(e){var i,o=t(this),n=o.attr("data-target")||e.preventDefault()||(i=o.attr("href"))&&i.replace(/.*(?=#[^\s]+$)/,""),s=t(n).data("collapse")?"toggle":o.data();o[t(n).hasClass("in")?"addClass":"removeClass"]("collapsed"),t(n).collapse(s)})}(window.jQuery),/* ============================================================
 * bootstrap-dropdown.js v2.2.2
 * http://twitter.github.com/bootstrap/javascript.html#dropdowns
 * ============================================================
 * Copyright 2012 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ============================================================ */
!function(t){"use strict";function e(){t(o).each(function(){i(t(this)).removeClass("open")})}function i(e){var i,o=e.attr("data-target");return o||(o=e.attr("href"),o=o&&/#/.test(o)&&o.replace(/.*(?=#[^\s]*$)/,"")),i=t(o),i.length||(i=e.parent()),i}var o="[data-toggle=dropdown]",n=function(e){var i=t(e).on("click.dropdown.data-api",this.toggle);t("html").on("click.dropdown.data-api",function(){i.parent().removeClass("open")})};n.prototype={constructor:n,toggle:function(){var o,n,s=t(this);if(!s.is(".disabled, :disabled"))return o=i(s),n=o.hasClass("open"),e(),n||o.toggleClass("open"),s.focus(),!1},keydown:function(e){var o,n,s,a,r;if(/(38|40|27)/.test(e.keyCode)&&(o=t(this),e.preventDefault(),e.stopPropagation(),!o.is(".disabled, :disabled"))){if(s=i(o),a=s.hasClass("open"),!a||a&&27==e.keyCode)return o.click();n=t("[role=menu] li:not(.divider):visible a",s),n.length&&(r=n.index(n.filter(":focus")),38==e.keyCode&&r>0&&r--,40==e.keyCode&&r<n.length-1&&r++,~r||(r=0),n.eq(r).focus())}}};var s=t.fn.dropdown;t.fn.dropdown=function(e){return this.each(function(){var i=t(this),o=i.data("dropdown");o||i.data("dropdown",o=new n(this)),"string"==typeof e&&o[e].call(i)})},t.fn.dropdown.Constructor=n,t.fn.dropdown.noConflict=function(){return t.fn.dropdown=s,this},t(document).on("click.dropdown.data-api touchstart.dropdown.data-api",e).on("click.dropdown touchstart.dropdown.data-api",".dropdown form",function(t){t.stopPropagation()}).on("touchstart.dropdown.data-api",".dropdown-menu",function(t){t.stopPropagation()}).on("click.dropdown.data-api touchstart.dropdown.data-api",o,n.prototype.toggle).on("keydown.dropdown.data-api touchstart.dropdown.data-api",o+", [role=menu]",n.prototype.keydown)}(window.jQuery),/* =========================================================
 * bootstrap-modal.js v2.2.2
 * http://twitter.github.com/bootstrap/javascript.html#modals
 * =========================================================
 * Copyright 2012 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ========================================================= */
!function(t){"use strict";var e=function(e,i){this.options=i,this.$element=t(e).delegate('[data-dismiss="modal"]',"click.dismiss.modal",t.proxy(this.hide,this)),this.options.remote&&this.$element.find(".modal-body").load(this.options.remote)};e.prototype={constructor:e,toggle:function(){return this[this.isShown?"hide":"show"]()},show:function(){var e=this,i=t.Event("show");this.$element.trigger(i),this.isShown||i.isDefaultPrevented()||(this.isShown=!0,this.escape(),this.backdrop(function(){var i=t.support.transition&&e.$element.hasClass("fade");e.$element.parent().length||e.$element.appendTo(document.body),e.$element.show(),i&&e.$element[0].offsetWidth,e.$element.addClass("in").attr("aria-hidden",!1),e.enforceFocus(),i?e.$element.one(t.support.transition.end,function(){e.$element.focus().trigger("shown")}):e.$element.focus().trigger("shown")}))},hide:function(e){e&&e.preventDefault();e=t.Event("hide"),this.$element.trigger(e),this.isShown&&!e.isDefaultPrevented()&&(this.isShown=!1,this.escape(),t(document).off("focusin.modal"),this.$element.removeClass("in").attr("aria-hidden",!0),t.support.transition&&this.$element.hasClass("fade")?this.hideWithTransition():this.hideModal())},enforceFocus:function(){var e=this;t(document).on("focusin.modal",function(t){e.$element[0]===t.target||e.$element.has(t.target).length||e.$element.focus()})},escape:function(){var t=this;this.isShown&&this.options.keyboard?this.$element.on("keyup.dismiss.modal",function(e){27==e.which&&t.hide()}):this.isShown||this.$element.off("keyup.dismiss.modal")},hideWithTransition:function(){var e=this,i=setTimeout(function(){e.$element.off(t.support.transition.end),e.hideModal()},500);this.$element.one(t.support.transition.end,function(){clearTimeout(i),e.hideModal()})},hideModal:function(){this.$element.hide().trigger("hidden"),this.backdrop()},removeBackdrop:function(){this.$backdrop.remove(),this.$backdrop=null},backdrop:function(e){var i=this.$element.hasClass("fade")?"fade":"";if(this.isShown&&this.options.backdrop){var o=t.support.transition&&i;this.$backdrop=t('<div class="modal-backdrop '+i+'" />').appendTo(document.body),this.$backdrop.click("static"==this.options.backdrop?t.proxy(this.$element[0].focus,this.$element[0]):t.proxy(this.hide,this)),o&&this.$backdrop[0].offsetWidth,this.$backdrop.addClass("in"),o?this.$backdrop.one(t.support.transition.end,e):e()}else!this.isShown&&this.$backdrop?(this.$backdrop.removeClass("in"),t.support.transition&&this.$element.hasClass("fade")?this.$backdrop.one(t.support.transition.end,t.proxy(this.removeBackdrop,this)):this.removeBackdrop()):e&&e()}};var i=t.fn.modal;t.fn.modal=function(i){return this.each(function(){var o=t(this),n=o.data("modal"),s=t.extend({},t.fn.modal.defaults,o.data(),"object"==typeof i&&i);n||o.data("modal",n=new e(this,s)),"string"==typeof i?n[i]():s.show&&n.show()})},t.fn.modal.defaults={backdrop:!0,keyboard:!0,show:!0},t.fn.modal.Constructor=e,t.fn.modal.noConflict=function(){return t.fn.modal=i,this},t(document).on("click.modal.data-api",'[data-toggle="modal"]',function(e){var i=t(this),o=i.attr("href"),n=t(i.attr("data-target")||o&&o.replace(/.*(?=#[^\s]+$)/,"")),s=n.data("modal")?"toggle":t.extend({remote:!/#/.test(o)&&o},n.data(),i.data());e.preventDefault(),n.modal(s).one("hide",function(){i.focus()})})}(window.jQuery),/* ===========================================================
 * bootstrap-tooltip.js v2.2.2
 * http://twitter.github.com/bootstrap/javascript.html#tooltips
 * Inspired by the original jQuery.tipsy by Jason Frame
 * ===========================================================
 * Copyright 2012 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ========================================================== */
!function(t){"use strict";var e=function(t,e){this.init("tooltip",t,e)};e.prototype={constructor:e,init:function(e,i,o){var n,s;this.type=e,this.$element=t(i),this.options=this.getOptions(o),this.enabled=!0,"click"==this.options.trigger?this.$element.on("click."+this.type,this.options.selector,t.proxy(this.toggle,this)):"manual"!=this.options.trigger&&(n="hover"==this.options.trigger?"mouseenter":"focus",s="hover"==this.options.trigger?"mouseleave":"blur",this.$element.on(n+"."+this.type,this.options.selector,t.proxy(this.enter,this)),this.$element.on(s+"."+this.type,this.options.selector,t.proxy(this.leave,this))),this.options.selector?this._options=t.extend({},this.options,{trigger:"manual",selector:""}):this.fixTitle()},getOptions:function(e){return e=t.extend({},t.fn[this.type].defaults,e,this.$element.data()),e.delay&&"number"==typeof e.delay&&(e.delay={show:e.delay,hide:e.delay}),e},enter:function(e){var i=t(e.currentTarget)[this.type](this._options).data(this.type);return i.options.delay&&i.options.delay.show?(clearTimeout(this.timeout),i.hoverState="in",void(this.timeout=setTimeout(function(){"in"==i.hoverState&&i.show()},i.options.delay.show))):i.show()},leave:function(e){var i=t(e.currentTarget)[this.type](this._options).data(this.type);return this.timeout&&clearTimeout(this.timeout),i.options.delay&&i.options.delay.hide?(i.hoverState="out",void(this.timeout=setTimeout(function(){"out"==i.hoverState&&i.hide()},i.options.delay.hide))):i.hide()},show:function(){var t,e,i,o,n,s,a;if(this.hasContent()&&this.enabled){switch(t=this.tip(),this.setContent(),this.options.animation&&t.addClass("fade"),s="function"==typeof this.options.placement?this.options.placement.call(this,t[0],this.$element[0]):this.options.placement,e=/in/.test(s),t.detach().css({top:0,left:0,display:"block"}).insertAfter(this.$element),i=this.getPosition(e),o=t[0].offsetWidth,n=t[0].offsetHeight,e?s.split(" ")[1]:s){case"bottom":a={top:i.top+i.height,left:i.left+i.width/2-o/2};break;case"top":a={top:i.top-n,left:i.left+i.width/2-o/2};break;case"left":a={top:i.top+i.height/2-n/2,left:i.left-o};break;case"right":a={top:i.top+i.height/2-n/2,left:i.left+i.width}}t.offset(a).addClass(s).addClass("in")}},setContent:function(){var t=this.tip(),e=this.getTitle();t.find(".tooltip-inner")[this.options.html?"html":"text"](e),t.removeClass("fade in top bottom left right")},hide:function(){function e(){var e=setTimeout(function(){i.off(t.support.transition.end).detach()},500);i.one(t.support.transition.end,function(){clearTimeout(e),i.detach()})}var i=this.tip();return i.removeClass("in"),t.support.transition&&this.$tip.hasClass("fade")?e():i.detach(),this},fixTitle:function(){var t=this.$element;(t.attr("title")||"string"!=typeof t.attr("data-original-title"))&&t.attr("data-original-title",t.attr("title")||"").removeAttr("title")},hasContent:function(){return this.getTitle()},getPosition:function(e){return t.extend({},e?{top:0,left:0}:this.$element.offset(),{width:this.$element[0].offsetWidth,height:this.$element[0].offsetHeight})},getTitle:function(){var t,e=this.$element,i=this.options;return t=e.attr("data-original-title")||("function"==typeof i.title?i.title.call(e[0]):i.title)},tip:function(){return this.$tip=this.$tip||t(this.options.template)},validate:function(){this.$element[0].parentNode||(this.hide(),this.$element=null,this.options=null)},enable:function(){this.enabled=!0},disable:function(){this.enabled=!1},toggleEnabled:function(){this.enabled=!this.enabled},toggle:function(e){var i=t(e.currentTarget)[this.type](this._options).data(this.type);i[i.tip().hasClass("in")?"hide":"show"]()},destroy:function(){this.hide().$element.off("."+this.type).removeData(this.type)}};var i=t.fn.tooltip;t.fn.tooltip=function(i){return this.each(function(){var o=t(this),n=o.data("tooltip"),s="object"==typeof i&&i;n||o.data("tooltip",n=new e(this,s)),"string"==typeof i&&n[i]()})},t.fn.tooltip.Constructor=e,t.fn.tooltip.defaults={animation:!0,placement:"top",selector:!1,template:'<div class="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>',trigger:"hover",title:"",delay:0,html:!1},t.fn.tooltip.noConflict=function(){return t.fn.tooltip=i,this}}(window.jQuery),/* ===========================================================
 * bootstrap-popover.js v2.2.2
 * http://twitter.github.com/bootstrap/javascript.html#popovers
 * ===========================================================
 * Copyright 2012 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * =========================================================== */
!function(t){"use strict";var e=function(t,e){this.init("popover",t,e)};e.prototype=t.extend({},t.fn.tooltip.Constructor.prototype,{constructor:e,setContent:function(){var t=this.tip(),e=this.getTitle(),i=this.getContent();t.find(".popover-title")[this.options.html?"html":"text"](e),t.find(".popover-content")[this.options.html?"html":"text"](i),t.removeClass("fade top bottom left right in")},hasContent:function(){return this.getTitle()||this.getContent()},getContent:function(){var t,e=this.$element,i=this.options;return t=e.attr("data-content")||("function"==typeof i.content?i.content.call(e[0]):i.content)},tip:function(){return this.$tip||(this.$tip=t(this.options.template)),this.$tip},destroy:function(){this.hide().$element.off("."+this.type).removeData(this.type)}});var i=t.fn.popover;t.fn.popover=function(i){return this.each(function(){var o=t(this),n=o.data("popover"),s="object"==typeof i&&i;n||o.data("popover",n=new e(this,s)),"string"==typeof i&&n[i]()})},t.fn.popover.Constructor=e,t.fn.popover.defaults=t.extend({},t.fn.tooltip.defaults,{placement:"right",trigger:"click",content:"",template:'<div class="popover"><div class="arrow"></div><div class="popover-inner"><h3 class="popover-title"></h3><div class="popover-content"></div></div></div>'}),t.fn.popover.noConflict=function(){return t.fn.popover=i,this}}(window.jQuery),/* =============================================================
 * bootstrap-scrollspy.js v2.2.2
 * http://twitter.github.com/bootstrap/javascript.html#scrollspy
 * =============================================================
 * Copyright 2012 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ============================================================== */
!function(t){"use strict";function e(e,i){var o,n=t.proxy(this.process,this),s=t(t(e).is("body")?window:e);this.options=t.extend({},t.fn.scrollspy.defaults,i),this.$scrollElement=s.on("scroll.scroll-spy.data-api",n),this.selector=(this.options.target||(o=t(e).attr("href"))&&o.replace(/.*(?=#[^\s]+$)/,"")||"")+" .nav li > a",this.$body=t("body"),this.refresh(),this.process()}e.prototype={constructor:e,refresh:function(){var e,i=this;this.offsets=t([]),this.targets=t([]),e=this.$body.find(this.selector).map(function(){var e=t(this),o=e.data("target")||e.attr("href"),n=/^#\w/.test(o)&&t(o);return n&&n.length&&[[n.position().top+i.$scrollElement.scrollTop(),o]]||null}).sort(function(t,e){return t[0]-e[0]}).each(function(){i.offsets.push(this[0]),i.targets.push(this[1])})},process:function(){var t,e=this.$scrollElement.scrollTop()+this.options.offset,i=this.$scrollElement[0].scrollHeight||this.$body[0].scrollHeight,o=i-this.$scrollElement.height(),n=this.offsets,s=this.targets,a=this.activeTarget;if(e>=o)return a!=(t=s.last()[0])&&this.activate(t);for(t=n.length;t--;)a!=s[t]&&e>=n[t]&&(!n[t+1]||e<=n[t+1])&&this.activate(s[t])},activate:function(e){var i,o;this.activeTarget=e,t(this.selector).parent(".active").removeClass("active"),o=this.selector+'[data-target="'+e+'"],'+this.selector+'[href="'+e+'"]',i=t(o).parent("li").addClass("active"),i.parent(".dropdown-menu").length&&(i=i.closest("li.dropdown").addClass("active")),i.trigger("activate")}};var i=t.fn.scrollspy;t.fn.scrollspy=function(i){return this.each(function(){var o=t(this),n=o.data("scrollspy"),s="object"==typeof i&&i;n||o.data("scrollspy",n=new e(this,s)),"string"==typeof i&&n[i]()})},t.fn.scrollspy.Constructor=e,t.fn.scrollspy.defaults={offset:10},t.fn.scrollspy.noConflict=function(){return t.fn.scrollspy=i,this},t(window).on("load",function(){t('[data-spy="scroll"]').each(function(){var e=t(this);e.scrollspy(e.data())})})}(window.jQuery),/* ========================================================
 * bootstrap-tab.js v2.2.2
 * http://twitter.github.com/bootstrap/javascript.html#tabs
 * ========================================================
 * Copyright 2012 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ======================================================== */
!function(t){"use strict";var e=function(e){this.element=t(e)};e.prototype={constructor:e,show:function(){var e,i,o,n=this.element,s=n.closest("ul:not(.dropdown-menu)"),a=n.attr("data-target");a||(a=n.attr("href"),a=a&&a.replace(/.*(?=#[^\s]*$)/,"")),n.parent("li").hasClass("active")||(e=s.find(".active:last a")[0],o=t.Event("show",{relatedTarget:e}),n.trigger(o),o.isDefaultPrevented()||(i=t(a),this.activate(n.parent("li"),s),this.activate(i,i.parent(),function(){n.trigger({type:"shown",relatedTarget:e})})))},activate:function(e,i,o){function n(){s.removeClass("active").find("> .dropdown-menu > .active").removeClass("active"),e.addClass("active"),a?(e[0].offsetWidth,e.addClass("in")):e.removeClass("fade"),e.parent(".dropdown-menu")&&e.closest("li.dropdown").addClass("active"),o&&o()}var s=i.find("> .active"),a=o&&t.support.transition&&s.hasClass("fade");a?s.one(t.support.transition.end,n):n(),s.removeClass("in")}};var i=t.fn.tab;t.fn.tab=function(i){return this.each(function(){var o=t(this),n=o.data("tab");n||o.data("tab",n=new e(this)),"string"==typeof i&&n[i]()})},t.fn.tab.Constructor=e,t.fn.tab.noConflict=function(){return t.fn.tab=i,this},t(document).on("click.tab.data-api",'[data-toggle="tab"], [data-toggle="pill"]',function(e){e.preventDefault(),t(this).tab("show")})}(window.jQuery),/* =============================================================
 * bootstrap-typeahead.js v2.2.2
 * http://twitter.github.com/bootstrap/javascript.html#typeahead
 * =============================================================
 * Copyright 2012 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ============================================================ */
!function(t){"use strict";var e=function(e,i){this.$element=t(e),this.options=t.extend({},t.fn.typeahead.defaults,i),this.matcher=this.options.matcher||this.matcher,this.sorter=this.options.sorter||this.sorter,this.highlighter=this.options.highlighter||this.highlighter,this.updater=this.options.updater||this.updater,this.source=this.options.source,this.$menu=t(this.options.menu),this.shown=!1,this.listen()};e.prototype={constructor:e,select:function(){var t=this.$menu.find(".active").attr("data-value");return this.$element.val(this.updater(t)).change(),this.hide()},updater:function(t){return t},show:function(){var e=t.extend({},this.$element.position(),{height:this.$element[0].offsetHeight});return this.$menu.insertAfter(this.$element).css({top:e.top+e.height,left:e.left}).show(),this.shown=!0,this},hide:function(){return this.$menu.hide(),this.shown=!1,this},lookup:function(){var e;return this.query=this.$element.val(),!this.query||this.query.length<this.options.minLength?this.shown?this.hide():this:(e=t.isFunction(this.source)?this.source(this.query,t.proxy(this.process,this)):this.source,e?this.process(e):this)},process:function(e){var i=this;return e=t.grep(e,function(t){return i.matcher(t)}),e=this.sorter(e),e.length?this.render(e.slice(0,this.options.items)).show():this.shown?this.hide():this},matcher:function(t){return~t.toLowerCase().indexOf(this.query.toLowerCase())},sorter:function(t){for(var e,i=[],o=[],n=[];e=t.shift();)e.toLowerCase().indexOf(this.query.toLowerCase())?~e.indexOf(this.query)?o.push(e):n.push(e):i.push(e);return i.concat(o,n)},highlighter:function(t){var e=this.query.replace(/[\-\[\]{}()*+?.,\\\^$|#\s]/g,"\\$&");return t.replace(new RegExp("("+e+")","ig"),function(t,e){return"<strong>"+e+"</strong>"})},render:function(e){var i=this;return e=t(e).map(function(e,o){return e=t(i.options.item).attr("data-value",o),e.find("a").html(i.highlighter(o)),e[0]}),e.first().addClass("active"),this.$menu.html(e),this},next:function(){var e=this.$menu.find(".active").removeClass("active"),i=e.next();i.length||(i=t(this.$menu.find("li")[0])),i.addClass("active")},prev:function(){var t=this.$menu.find(".active").removeClass("active"),e=t.prev();e.length||(e=this.$menu.find("li").last()),e.addClass("active")},listen:function(){this.$element.on("blur",t.proxy(this.blur,this)).on("keypress",t.proxy(this.keypress,this)).on("keyup",t.proxy(this.keyup,this)),this.eventSupported("keydown")&&this.$element.on("keydown",t.proxy(this.keydown,this)),this.$menu.on("click",t.proxy(this.click,this)).on("mouseenter","li",t.proxy(this.mouseenter,this))},eventSupported:function(t){var e=t in this.$element;return e||(this.$element.setAttribute(t,"return;"),e="function"==typeof this.$element[t]),e},move:function(t){if(this.shown){switch(t.keyCode){case 9:case 13:case 27:t.preventDefault();break;case 38:t.preventDefault(),this.prev();break;case 40:t.preventDefault(),this.next()}t.stopPropagation()}},keydown:function(e){this.suppressKeyPressRepeat=~t.inArray(e.keyCode,[40,38,9,13,27]),this.move(e)},keypress:function(t){this.suppressKeyPressRepeat||this.move(t)},keyup:function(t){switch(t.keyCode){case 40:case 38:case 16:case 17:case 18:break;case 9:case 13:if(!this.shown)return;this.select();break;case 27:if(!this.shown)return;this.hide();break;default:this.lookup()}t.stopPropagation(),t.preventDefault()},blur:function(){var t=this;setTimeout(function(){t.hide()},150)},click:function(t){t.stopPropagation(),t.preventDefault(),this.select()},mouseenter:function(e){this.$menu.find(".active").removeClass("active"),t(e.currentTarget).addClass("active")}};var i=t.fn.typeahead;t.fn.typeahead=function(i){return this.each(function(){var o=t(this),n=o.data("typeahead"),s="object"==typeof i&&i;n||o.data("typeahead",n=new e(this,s)),"string"==typeof i&&n[i]()})},t.fn.typeahead.defaults={source:[],items:8,menu:'<ul class="typeahead dropdown-menu"></ul>',item:'<li><a href="#"></a></li>',minLength:1},t.fn.typeahead.Constructor=e,t.fn.typeahead.noConflict=function(){return t.fn.typeahead=i,this},t(document).on("focus.typeahead.data-api",'[data-provide="typeahead"]',function(e){var i=t(this);i.data("typeahead")||(e.preventDefault(),i.typeahead(i.data()))})}(window.jQuery),/* ==========================================================
 * bootstrap-affix.js v2.2.2
 * http://twitter.github.com/bootstrap/javascript.html#affix
 * ==========================================================
 * Copyright 2012 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ========================================================== */
!function(t){"use strict";var e=function(e,i){this.options=t.extend({},t.fn.affix.defaults,i),this.$window=t(window).on("scroll.affix.data-api",t.proxy(this.checkPosition,this)).on("click.affix.data-api",t.proxy(function(){setTimeout(t.proxy(this.checkPosition,this),1)},this)),this.$element=t(e),this.checkPosition()};e.prototype.checkPosition=function(){if(this.$element.is(":visible")){var e,i=t(document).height(),o=this.$window.scrollTop(),n=this.$element.offset(),s=this.options.offset,a=s.bottom,r=s.top,l="affix affix-top affix-bottom";"object"!=typeof s&&(a=r=s),"function"==typeof r&&(r=s.top()),"function"==typeof a&&(a=s.bottom()),e=null!=this.unpin&&o+this.unpin<=n.top?!1:null!=a&&n.top+this.$element.height()>=i-a?"bottom":null!=r&&r>=o?"top":!1,this.affixed!==e&&(this.affixed=e,this.unpin="bottom"==e?n.top-o:null,this.$element.removeClass(l).addClass("affix"+(e?"-"+e:"")))}};var i=t.fn.affix;t.fn.affix=function(i){return this.each(function(){var o=t(this),n=o.data("affix"),s="object"==typeof i&&i;n||o.data("affix",n=new e(this,s)),"string"==typeof i&&n[i]()})},t.fn.affix.Constructor=e,t.fn.affix.defaults={offset:0},t.fn.affix.noConflict=function(){return t.fn.affix=i,this},t(window).on("load",function(){t('[data-spy="affix"]').each(function(){var e=t(this),i=e.data();i.offset=i.offset||{},i.offsetBottom&&(i.offset.bottom=i.offsetBottom),i.offsetTop&&(i.offset.top=i.offsetTop),e.affix(i)})})}(window.jQuery);