/*
 * Ext JS Library 2.1
 * Copyright(c) 2006-2008, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://extjs.com/license
 */

Ext.ProgressBar=Ext.extend(Ext.BoxComponent,{baseCls:"x-progress",waitTimer:null,initComponent:function(){Ext.ProgressBar.superclass.initComponent.call(this);this.addEvents("update")},onRender:function(D,A){Ext.ProgressBar.superclass.onRender.call(this,D,A);var C=new Ext.Template("<div class=\"{cls}-wrap\">","<div class=\"{cls}-inner\">","<div class=\"{cls}-bar\">","<div class=\"{cls}-text\">","<div>&#160;</div>","</div>","</div>","<div class=\"{cls}-text {cls}-text-back\">","<div>&#160;</div>","</div>","</div>","</div>");if(A){this.el=C.insertBefore(A,{cls:this.baseCls},true)}else{this.el=C.append(D,{cls:this.baseCls},true)}if(this.id){this.el.dom.id=this.id}var B=this.el.dom.firstChild;this.progressBar=Ext.get(B.firstChild);if(this.textEl){this.textEl=Ext.get(this.textEl);delete this.textTopEl}else{this.textTopEl=Ext.get(this.progressBar.dom.firstChild);var E=Ext.get(B.childNodes[1]);this.textTopEl.setStyle("z-index",99).addClass("x-hidden");this.textEl=new Ext.CompositeElement([this.textTopEl.dom.firstChild,E.dom.firstChild]);this.textEl.setWidth(B.offsetWidth)}this.progressBar.setHeight(B.offsetHeight)},afterRender:function(){Ext.ProgressBar.superclass.afterRender.call(this);if(this.value){this.updateProgress(this.value,this.text)}else{this.updateText(this.text)}},updateProgress:function(B,C){this.value=B||0;if(C){this.updateText(C)}var A=Math.floor(B*this.el.dom.firstChild.offsetWidth);this.progressBar.setWidth(A);if(this.textTopEl){this.textTopEl.removeClass("x-hidden").setWidth(A)}this.fireEvent("update",this,B,C);return this},wait:function(B){if(!this.waitTimer){var A=this;B=B||{};this.waitTimer=Ext.TaskMgr.start({run:function(C){var D=B.increment||10;this.updateProgress(((((C+D)%D)+1)*(100/D))*0.01)},interval:B.interval||1000,duration:B.duration,onStop:function(){if(B.fn){B.fn.apply(B.scope||this)}this.reset()},scope:A})}return this},isWaiting:function(){return this.waitTimer!=null},updateText:function(A){this.text=A||"&#160;";this.textEl.update(this.text);return this},setSize:function(A,C){Ext.ProgressBar.superclass.setSize.call(this,A,C);if(this.textTopEl){var B=this.el.dom.firstChild;this.textEl.setSize(B.offsetWidth,B.offsetHeight)}return this},reset:function(A){this.updateProgress(0);if(this.textTopEl){this.textTopEl.addClass("x-hidden")}if(this.waitTimer){this.waitTimer.onStop=null;Ext.TaskMgr.stop(this.waitTimer);this.waitTimer=null}if(A===true){this.hide()}return this}});Ext.reg("progress",Ext.ProgressBar);