Content-Type: multipart/mixed; boundary="===============7559312843484525601=="
MIME-Version: 1.0
From: Nicola Mfb <nicola.mfb@gmail.com>
Subject: Re: [PATCH 2/2] Added SQLite history plugin
Date: Wed, 07 Apr 2010 21:20:11 +0200
Message-ID: <o2y359c5481004071220j1420a157k7f959b9068d4f79@mail.gmail.com>
In-Reply-To: <201004071305.35438.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7559312843484525601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 7, 2010 at 8:05 PM, Denis Kenzior <denkenz@gmail.com> wrote:
[...]
>> We prefer to have the id to easily sync with the history plugin, as
>> said in previous mail, if you prefer to not expose the id on
>> IncomingMessage, we may emit an HistoryIncomingMessage signal with the
>> id.
>
> Your plugin is free to do anything it wants. =C2=A0The real question is w=
hether you
> truly need this id or you can simply update the application state based o=
n the
> IncomingMessage signal only.

An use case may explain that better.

I have an app that listen for incoming messages and forwards them by mail.

After sending X messages the app goes down for some reason, when comes
up again there are Y messages in the history plugin becouse Y-X new
messages arrived.

Well, I want my app to be able to recover from the downtime using the
history plugin, and want to avoid to resend the first X messages.

A simple way to achieve that is adding the id in the IncomingMessage
signal, so the app is able to store it somewhere every time it
receives a new message.

When the app start, it simply query the history plugin and start
processing only messages where id > lastsavedid.

Of course this is only an easy way to achieve that, I may use the
timestamps, but really I do not trust them, it may be I'm missing
somethingh here, is there an easy/elegant alternative?

A real case may be to powerup the modem at device startup to get
already a network registration while the gui comes later, or the user
volontary restarts the gui, etc.

Regards

       Niko

--===============7559312843484525601==--

