Content-Type: multipart/mixed; boundary="===============3233737106674656833=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCHv2 1/4] Automatic provisioning of GPRS context settings
Date: Mon, 03 Jan 2011 15:03:48 -0800
Message-ID: <1294095828.5852.54.camel@aeonflux>
In-Reply-To: <1294039912-6008-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3233737106674656833==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

> Here is another RFC patchset about implementing automatic provisioning of=
 Internet and MMS GPRS context settings. ("Internet Access Provider databas=
e" TODO item).
> =

> In case there are no previously configured contexts found during gprs ato=
m registration, this code tries to provision Internet and MMS contexts base=
d on MCC, MNC and SPN (Service Provider Name) values read from SIM. Setting=
s are read from an operator settings database.

thinking about this a bit more and with the background that there is
already an existing public database, we might should just enable a
provision driver inside the oFono core.

Meaning that we can have multiple implementations of different databases
with just different priorities. Each nicely separated in their own
plugin and we don't bother the oFono core with where to get the data
from. So my idea would be that the oFono core just asks to provision a
new context. If a plugin feels responsible, then it does so. If not then
it stays empty.

Running oFono on the desktop/netbook etc. it makes sense to use the
current mobile broadband provider database. However on a phone that is a
not so good database. And for you guys it would also be possible to
continue using a CSV based format.

Thoughts?

Regards

Marcel



--===============3233737106674656833==--

