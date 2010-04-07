Content-Type: multipart/mixed; boundary="===============9015498837615803137=="
MIME-Version: 1.0
From: Nicola Mfb <nicola.mfb@gmail.com>
Subject: Re: [PATCH 2/2] Added SQLite history plugin
Date: Wed, 07 Apr 2010 13:47:13 +0200
Message-ID: <x2j359c5481004070447q282f7d6elc7931e64b2fb9120@mail.gmail.com>
In-Reply-To: <201004061256.46026.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9015498837615803137==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 6, 2010 at 7:56 PM, Denis Kenzior <denkenz@gmail.com> wrote:

[...]

Hi Denis,

Actually our apps listen for the IncomingMessage signal, and store the
SMS in an internal database.
At some point by design, a restart, a crash or other reasons, it may
happen that apps are down while ofono and the modem are up, in that
case we lose incoming messages.

To solve this we tought to use the history, so, for example, clients
at startup query the plugin, processes "lost" messages and further
continue listening for the IncomingMessage signal.

We have a problem here, as the IncomingMessage lacks for the sms id
property, we generate an internal id that is out of sync respect of
ther history id, so at the next app restart we cannot determine what
messages were "lost".

The second problem is that we may use several clients at the same
time, thinks for a phone app, and a desktop widget showing the number
of incoming/unread etc. messages.
The two clients needs to access the same informations in a consistent way.

For that reason, and due the necessity to abstract the db access with
a dbus api, we thought the natural way is to use the history plugin as
a "permanent storage" plugin too, improving the dbus interface to have
clients cooperating in a consistent manner, and avoiding duplicate
sms/calls data in different places.

The phone app may request to delete a "message", and a
"HistoryMessageDeleted" signal should be emitted, and so on.

Here we may have an HistoryIncomingMessage signal that provides the id
field too and fix the first issue (if you do not prefer to add the id
field in the IncomingMessage signal directly).

The plugin may be used to store further metadata providing signals to
inform of their changes, that my be useful in all clients (if a
message was read in the phone app, the desktop widget should take care
of that and decrease the showed number of new messages).

Finally apps may decide with the right dbus calls if sms listing has
to be filtered by sim or not, or when and how expire the history.

But thats impacts a lot on the general perspective of the history
plugin usage and further developing.

Infact if a complete dbus api is going to be defined, it would be nice
to share it for all history plugins, adding for example an
"org.ofono.HistoryManager" interface to the modem, while if the
history plugin has to be used in a different manner, or ofono does not
care of that by design, we have to implement the dbus interface in the
sqlite plugin directly, forcing our apps to not be generally oFono
compliants (at least when not using the sqlite plugin).

So we are asking to you what's are your plans and how may we proceed.

Thanks for your support!

    Niko

--===============9015498837615803137==--

