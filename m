Content-Type: multipart/mixed; boundary="===============7886075994199086834=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: [RFC] Refactoring ISI modem support
Date: Mon, 15 Nov 2010 02:31:05 +0200
Message-ID: <AANLkTikzdhi9H7qKJf=riBudUH+-fWqPU7xwjA81DXoM@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7886075994199086834==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

I've been working on improving the ISI modem support in oFono, mostly
concentrating on the gisi library, but also on tweaking the drivers
and plugins. You can follow the progress of this 'gisi' branch here:

git://gitorious.org/~akiniemi/meego-cellular/ofono-aki.git

http://meego.gitorious.org/~akiniemi/meego-cellular/ofono-aki/trees/gisi

This is now shaping up enough to call for a bit wider review. Gisi is
mostly where I think it should be, and seems to work. The new
(redesigned, really) version is fixing some of the long-standing
complaints. For instance, it is now using only a single PhoNet socket,
managing indication subscriptions and reachability queries a bit more
intelligently, and is caching modem reachability status and ISI
resource versions for as long as the modem plugin is registered.

Note that not all of the drivers or the n900 plugin have yet been
adapted, but those that are seem to work.

I would really appreciate any comments you might have. Especially
if you are working with gisi or isimodem, please take a look. The plan
is to adapt the rest of the drivers and the n900 plugin in the next
couple of weeks, test some more, rebase, and apply to the
master tree.

Cheers,
Aki

--===============7886075994199086834==--

