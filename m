Content-Type: multipart/mixed; boundary="===============4439777255967556275=="
MIME-Version: 1.0
From: Shane Bryan <shane.bryan@linux.intel.com>
Subject: Re: [PATCH] doc: stk-api proposal
Date: Wed, 21 Jul 2010 15:06:47 -0700
Message-ID: <20100721150647.299b4f5b@sbryan-MOBL6>
In-Reply-To: <1279578528-22281-1-git-send-email-denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4439777255967556275==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Jul 2010 17:28:48 -0500
Denis Kenzior <denkenz@gmail.com> wrote:

> Up for comment is the Sim Application Toolkit API proposal for
> oFono.  It is largely based on Andrew's API proposal with several
> changes in areas I felt needed further attention.  I'd like all
> interested to comment, what looks good, what looks crummy?  Is
> anything missing?

General comments, from the perspective of one who may end writing an
STK Agent app/ui in MeeGo:

- Having not read the full spec, what (if any) considerations need to
  be made for locales and multi-byte characters that could be entered
  if the UI is running in a multi-byte locale?

  Addendum: I now see the spec has the LANGUAGE NOTIFICATION Proactive
  Command.  Any early ideas on if/how this would be implemented and
  what should be done from a UI perspective if the language does not
  match the current runtime locale and/or language, esp if they differ
  in directionality (right-to-left vs. left-to-right)? =


- Same for translations?  Do the strings provided need to be
  translated, or is that left as a function of the SIM vendor and the
  region the card is coded for?

  If the LANGUAGE NOTIFICATION *is* implemented, then I assume the
  agent writer would not have to deal with translation issues for text
  provided by the SIM application.  I would assume strings following a
  change in language notification would be "pre-translated"... fair
  assumption?

- Does the spec, or will ofono, define the max length of the strings
  passed for any properties that will result in the display of text on
  screen?

> +SimToolkit Hierarchy
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Service		org.ofono
> +Interface	org.ofono.SimToolkit

- I take it this interface is independent of the org.ofono.manager and
  org.ofono.modem interfaces?

> +Object path	[variable prefix]/{modem0,modem1,...}

- Does this modem path map exactly to the path provided through
  org.ofono.manager.GetProperties() or can/will it be completely
  orthogonal to it?

- If closely tied to the "Modems" propertied in the Manager
  interface, what is the effect (if any) to changes in the "Powered"
  state on the modem when triggered via a call to
  org.ofono.Modem.SetProperties() for that modem path?

  Will it trigger a Unregister or PropertyChanged signal to the agent
  and/or toolkit interfaces?
 =

> +
> +Methods		dict GetProperties()
> +
> +			Returns properties for the SimToolkit
> object.  See the
> +			properties section for available properties.
> +
> +			Possible Errors:
> [service].Error.InvalidArguments +
> +		void RegisterAgent(object path)
> +
> +			Registers a default agent to be used for SIM
> initiated
> +			actions such as Display Text, Get Inkey or
> Get Input.
> +			These can typically occur when a special SMS
> is
> +			received and might not involve interaction
> from the
> +			user.
> +
> +			Possible Errors:
> [service].Error.InvalidArguments
> +
> [service].Error.InvalidFormat
> +					 [service].Error.InUse
> +

- Is the RegisterAgent() method used to inform UICC of "Terminal
  Applications" and if so, what is the set of "well known" "Terminal
  Applications" that cards use to refer to "launch-able" applications
  (reading section 7.8.1 from ETSI 102.223)?  It would sound like there
  is not such list, except as defined by SIM card providers, correct?

  If so, are there plans to have ofono define/use a set of well known
  applications and perform any translations needed by vendors with a
  config file or plugin?  Again, having not read the entire spec, I
  could be asking hair-brained questions, feel free to enlighten ;)

- The API seems to suggest that there is one and only one Agent
  registered at any time, correct?

  If so, does this "default" agent then need to handle *all* SIM actions (I
  would assume so if certification is desired.

  If not, how would one associate the Agent at one ObjectPath as the
  handler for a specific (or subset of possible) action request(s)?

> +		void UnregisterAgent(object path)
> +
> +			Unregisters the default agent.  If no agent
> is
> +			registered then unsolicited commands from
> the SIM
> +			are rejected.
> +
> +			Possible Errors:

- I gather that a call to UnregisterAgent() will result in the
  Release() method of the named agent (if existing) being called,
  correct?

> +					 [service].Error.NotFound
> +
> [service].Error.NotAuthorized +

- What are the plans for the configuration of services/object paths for
  "launch-able" Terminal Applications (AKA, Agents?)?  Will there be a
  stk.conf file or similar or will this be protected in a dbus service
  config file?

- Signals?  Surely we at least need a PropertyChanged() signal?

> +		array{string} MainMenuItems
> +
> +			Contains the items that make up the main
> menu.  This
> +			is populated by the SIM when it sends the
> Setup Menu
> +			Proactive Command.  The main menu is always
> available,
> +			but its contents can be changed at any time.

- So subsequent changes to MainMenuItems (presumably through a
  PropertyChanged or equivalent signal?) are to be considered complete
  replacements for the currently displayed menu items, or must the
  array be traversed and compared with current to identify new or
  removed items?

> +
> +		array{array{bytes}} MainMenuIcons
> +
> +			Contains the icons associated with the main
> menu items. +

- Does the spec (or ofonos interpretation and implementation of it)
  plan to enforce any constraints on the 1:1 association of icons to
  menu items?

  IOW, can the MainMenuItems array contain a different number of
  entries than are in the MainMenuIcons array?  If so, how do you
  propose the keep them properly aligned?  If not (both arrays must
  have same number of entries), can a given index in the icons array be
  empty, indicating not icon is displayed for the matching index in the
  MainMenuItems array?

- Does the spec, or will ofono, define the specific format of the byte
  data being used to pass the icon data?

  If not, I suggest a property that hold an icon format identifier,
  "string IconFormat" as an example



> +SimToolkitAgent Hierarchy
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Service		unique name
> +Interface	org.ofono.SimToolkitAgent
> +Object path	freely definable
> +
> +Methods		byte SelectItem(string title, array{string}
> items,
> +				array{array{byte}} icons, byte
> default) +
> +			Tells the agent to ask the user to select an
> item
> +			from the menu.  This function should return
> the index
> +			of the item or an error given below:

- Not to make any assumptions, but does the SIM/UICC define whether
  index returns are expected as 0 or 1 based?

- Same questions regarding item<->icon array mappings as above in
  MainMenu* properties?  Should the agent enforce any specific rules
  between these two arrays, and if so, what (if any) errors should be
  returned?

> +
> +			Possible Errors:
> [service].Error.SimToolkit.GoBack +

- Can you describe a use case where I, as the Agent writer, would need
  to reply with a "GoBack" error, and what it means from a UI
  perspective?

  I read it as, "User made no selection, but instead hit the escape or
  'go back' button and made no choice".  Is this a correct
  understanding?


> +		string GetInput(string alpha, array{byte} icon,
> +				string default, byte min, byte max,
> +				boolean hide_typing)
> +
> +			Tells the agent to request an input string
> from the
> +			user.  The alpha parameter and icon gives
> context to
> +			the user.  The default string contains the
> suggested
> +			default by the SIM.  The min and max
> parameters contain
> +			how many characters the user should enter.
> The
> +			parameter hide_typing indicates whether
> user's typing
> +			should be opaque.
> +
> +			Possible Errors:
> [service].Error.SimToolkit.GoBack +

- Same questions as above regarding the icon data formatting.

- Given the min/max constraints, plus the default value, I assume
  that if the input provided by the user falls within (inclusive) both
  conditions, this is what is returned, otherwise the value of default
  is returned, correct?

- Can min or max ever be 0, and if so, should unconstrained strings be
  returned or is there a spec defined max length for strings?
 =



> +		string GetKey(string alpha, array{byte} icon)
> +
> +			Tells the agent to request a single input
> key from
> +			the user.  The alpha parameter contains the
> context
> +			for the request.
> +
> +			Possible Errors:
> [service].Error.SimToolkit.GoBack +

- I am assuming this "Key" is in fact meant to imply a single
  Character, not a scan code or keycode from some hardware key,
  correct?  May seem obvious to some, but I can't always be sure.

  If so, isn't this just a special case of GetInput, with min and max
  both set to 0?


> +		boolean GetConfirmation(string alpha, array{byte}
> icon) +
> +			Asks the agent to get confirmation from the
> user. +
> +			Possible Errors:
> [service].Error.SimToolkit.GoBack +

- Depending on the app/query, the text of the confirmation options
  could be any of the following (at least):

  yes/no                      (prompted to reboot)
  cancel/continue             (prompted to install an application)
  "I agree"/"I do not agree"  (prompted to agree to EULA?)
  next/previous               (progressing through a series of dialogs)
  ...

  Given this, I could see the need for this API to contain parameters
  for the strings that should represent the "true" and "false"
  selection results.

  This of course gets tricky if the locale and translations come into
  play here...

  What Proactive UICC command does this map to anyway?  I don't see
  any obvious compliment in the spec?
 =



> +		void Release()
> +
> +			Agent is being released, possibly because of
> oFono
> +			terminating, SimToolkit interface torn down
> or modem
> +			off.  If the agent is registered as a global
> agent,
> +			no UnregisterAgent call is expected.

Ok, so in this case, the SimToolkit will call the agents Release()
method when (as asked above in the RegisterAgent() comments) the modem
Powered state goes from true to false (as well as under other possible
conditions, yeah, I know), correct?

Shane...

--===============4439777255967556275==--

