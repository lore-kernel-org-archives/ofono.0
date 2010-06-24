Content-Type: multipart/mixed; boundary="===============6852866908063798618=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: SimApplicationAgent api
Date: Thu, 24 Jun 2010 20:39:44 +0200
Message-ID: <AANLkTikLieHEMc_aNHVBq5eG1W1WGr1U4DVYvTvIL6tH@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6852866908063798618==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Here are two ways the dbus interface for stk may look, specifically
the part that requires a UI.  Comments welcome.

org.ofono.SimApplicationAgent
Methods
  (int item, bool help) or GoBack/Terminate Menu(string title,
                array{string} items, bool has_help, bool
                soft_key_preferred, bool is_main_menu)
     Handles both Set Up Menu type of menu and Select Item
     since they're identical.

  Ok/GoBack/Terminate DisplayText(string text,
                bool urgent, bool confirmation)
     The UI should show the message, optionally asking the
     user for confirmation.  If no confirmation is asked, the text
     can'te be Ok'ed and should stay until Cancel()ed.  There
     are things like frames and the text can be sent to specific
     frame but let's skip them at this point.

  string GetInput(...)
  string GetInKey(...)
  void Cancel(void)

org.ofono.SimToolkit
Methods
  void RegisterAgent(object)
  void UnregisterAgent(object)
Properties
  string IdleText
  int CommandTimeout

When an agent registers, it gets sent whatever command is currently
executing, or the main menu.  Note that we could just respond with
UserEndedSession to any command that arrives when no agent is
registered, or when agent unregisters, but the D-Bus specs say the
client should be able to disconnect and reconnect without affecting
state of the application.

Second possibility is for main menu to be on the SimToolkit interface

org.ofono.SimToolkit
Methods
  void Select(int)
  void RequestHelp(int)

Properties
  string IdleText
  int CommandTimeout
  string MenuTitle
  array{string} MenuItems
  bool MenuSoftKeyPreferred
  bool MenuHelpAvailable
    These would describe main menu, but they would be emptied
    whenever a command is waiting for agent's response, because
    menu is not available then.  Select Item would remain on the
    Agent interface.

It's also possible to not use the agent.

Regards

--===============6852866908063798618==--

