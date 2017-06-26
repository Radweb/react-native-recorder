using ReactNative.Bridge;
using System;
using System.Collections.Generic;
using Windows.ApplicationModel.Core;
using Windows.UI.Core;

namespace Com.Reactlibrary.RWRecorder
{
    /// <summary>
    /// A module that allows JS to share data.
    /// </summary>
    class RWRecorderModule : NativeModuleBase
    {
        /// <summary>
        /// Instantiates the <see cref="RWRecorderModule"/>.
        /// </summary>
        internal RWRecorderModule()
        {

        }

        /// <summary>
        /// The name of the native module.
        /// </summary>
        public override string Name
        {
            get
            {
                return "RWRecorder";
            }
        }
    }
}
