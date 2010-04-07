Content-Type: multipart/mixed; boundary="===============7054393137185468932=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] Added SQLite history plugin
Date: Wed, 07 Apr 2010 14:28:22 -0500
Message-ID: <201004071428.22605.denkenz@gmail.com>
In-Reply-To: <x2j359c5481004070447q282f7d6elc7931e64b2fb9120@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7054393137185468932==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Niko,

> Infact if a complete dbus api is going to be defined, it would be nice
> to share it for all history plugins, adding for example an
> "org.ofono.HistoryManager" interface to the modem, while if the
> history plugin has to be used in a different manner, or ofono does not
> care of that by design, we have to implement the dbus interface in the
> sqlite plugin directly, forcing our apps to not be generally oFono
> compliants (at least when not using the sqlite plugin).

So today I would consider this to be out-of-scope for the oFono project.  W=
e =

really want to concentrate on being the telephony stack and leave the =

peripheral aspects to integrators.  However, I do realize this is still =

largely uncharted territory, so any suggestions you have on how oFono core =
can =

make your life easier in this space are definitely welcome.

In the end some decision has to be made regarding the storage backend.  =

Whether it is MySQL, SQLite, Tracker, EDS, portable black holes, etc.  I =

prefer to leave this to each distribution / platform instead of mandating a =

solution.  In the end we're telephony experts, none of us is an expert with =

contacts or databases.

Regards,
-Denis

--===============7054393137185468932==--

