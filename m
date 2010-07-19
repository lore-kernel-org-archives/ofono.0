Content-Type: multipart/mixed; boundary="===============5031337354820016143=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] doc: stk-api proposal
Date: Mon, 19 Jul 2010 17:28:48 -0500
Message-ID: <1279578528-22281-1-git-send-email-denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5031337354820016143==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Up for comment is the Sim Application Toolkit API proposal for oFono.  It is
largely based on Andrew's API proposal with several changes in areas I felt
needed further attention.  I'd like all interested to comment, what looks
good, what looks crummy?  Is anything missing?

Please note that the proposal only covers Setup Menu, Setup Idle Mode Text,
Select Item, Display Text, Get Inkey and Get Input proactive commands.

Also, several aspects of these commands are explicitly ignored, e.g. the us=
er
help system.
---
 doc/stk-api.txt |  162 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 162 insertions(+), 0 deletions(-)
 create mode 100644 doc/stk-api.txt

diff --git a/doc/stk-api.txt b/doc/stk-api.txt
new file mode 100644
index 0000000..96bf710
--- /dev/null
+++ b/doc/stk-api.txt
@@ -0,0 +1,162 @@
+SimToolkit Hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.SimToolkit
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		dict GetProperties()
+
+			Returns properties for the SimToolkit object.  See the
+			properties section for available properties.
+
+			Possible Errors: [service].Error.InvalidArguments
+
+		void RegisterAgent(object path)
+
+			Registers a default agent to be used for SIM initiated
+			actions such as Display Text, Get Inkey or Get Input.
+			These can typically occur when a special SMS is
+			received and might not involve interaction from the
+			user.
+
+			Possible Errors: [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.InUse
+
+		void UnregisterAgent(object path)
+
+			Unregisters the default agent.  If no agent is
+			registered then unsolicited commands from the SIM
+			are rejected.
+
+			Possible Errors: [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.NotFound
+					 [service].Error.NotAuthorized
+
+Properties	string IdleText
+
+			Contains the text to be used when the home screen is
+			idle.  This text is set by the SIM and can be changed
+			at any time.
+
+		array{string} MainMenuItems
+
+			Contains the items that make up the main menu.  This
+			is populated by the SIM when it sends the Setup Menu
+			Proactive Command.  The main menu is always available,
+			but its contents can be changed at any time.
+
+		array{array{bytes}} MainMenuIcons
+
+			Contains the icons associated with the main menu items.
+
+		string MainMenuTitle
+
+			Contains the title of the main menu.
+
+SimToolkitAgent Hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		unique name
+Interface	org.ofono.SimToolkitAgent
+Object path	freely definable
+
+Methods		byte SelectItem(string title, array{string} items,
+				array{array{byte}} icons, byte default)
+
+			Tells the agent to ask the user to select an item
+			from the menu.  This function should return the index
+			of the item or an error given below:
+
+			Possible Errors: [service].Error.SimToolkit.GoBack
+
+			Implementation notes:
+
+			- Data / Navigation type not indicated
+			- Soft key preferred not indicated
+			- Help available ignored
+
+		void DisplayText(string text, boolean urgent)
+
+			Tells the agent to display text from the SIM.  The
+			boolean urgent parameter tells the agent whether this
+			is an urgent message and all other messages should be
+			cleared prior to the display of this text.
+
+			Possible Errors: [service].Error.SimToolkit.GoBack
+
+			Implementation notes:
+
+			- High / normal priority indicated by urgent
+			- clear / wait for user handled by setting a higher
+			  timeout in the case of wait for user flag and using
+			  the Cancel() method appropriately.  If the agent
+			  returns earlier from this method call, a terminal
+			  response is sent.
+			- Immediate Response indication is handled internally,
+			  terminal response is sent immediately and no other
+			  indication is given to the user / agent.  Response
+			  from this method call is ignored and an infinite
+			  timeout is used for the method call.  Once another
+			  proactive command arrives, and the DisplayText is
+			  still pending, Cancel() is called.
+
+		string GetInput(string alpha, array{byte} icon,
+				string default, byte min, byte max,
+				boolean hide_typing)
+
+			Tells the agent to request an input string from the
+			user.  The alpha parameter and icon gives context to
+			the user.  The default string contains the suggested
+			default by the SIM.  The min and max parameters contain
+			how many characters the user should enter.  The
+			parameter hide_typing indicates whether user's typing
+			should be opaque.
+
+			Possible Errors: [service].Error.SimToolkit.GoBack
+
+		string GetDigits(string alpha, array{byte} icon,
+					string default, byte min, byte max,
+					boolean hide_typing)
+
+			Same as GetInput but only digit characters (0-9, *#+)
+			are expected.
+
+			Possible Errors: [service].Error.SimToolkit.GoBack
+
+		string GetKey(string alpha, array{byte} icon)
+
+			Tells the agent to request a single input key from
+			the user.  The alpha parameter contains the context
+			for the request.
+
+			Possible Errors: [service].Error.SimToolkit.GoBack
+
+		string GetDigit(string alpha, array{byte} icon)
+
+			Same as above, but only digits (0-9, *#+) are
+			expected.
+
+			Possible Errors: [service].Error.SimToolkit.GoBack
+
+		boolean GetConfirmation(string alpha, array{byte} icon)
+
+			Asks the agent to get confirmation from the user.
+
+			Possible Errors: [service].Error.SimToolkit.GoBack
+
+		void Cancel()
+
+			Asks the agent to cancel any ongoing operation in
+			progress.  This is usually either because the agent
+			is taking too long to respond or the Sim Application
+			has terminated the session.
+
+		void Release()
+
+			Agent is being released, possibly because of oFono
+			terminating, SimToolkit interface torn down or modem
+			off.  If the agent is registered as a global agent,
+			no UnregisterAgent call is expected.
-- =

1.7.0.4


--===============5031337354820016143==--

