Content-Type: multipart/mixed; boundary="===============1848393035169339735=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: RE: [PATCH 2/2] Added SQLite history plugin
Date: Wed, 07 Apr 2010 10:28:02 -0700
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C9C1410FA5@orsmsx508.amr.corp.intel.com>
In-Reply-To: <x2j359c5481004070447q282f7d6elc7931e64b2fb9120@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1848393035169339735==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Hi Denis,
> =

> Actually our apps listen for the IncomingMessage signal, and store the
> SMS in an internal database.
> At some point by design, a restart, a crash or other reasons, it may
> happen that apps are down while ofono and the modem are up, in that
> case we lose incoming messages.

A similar lack of robustness exists at the modem API side as well, if oFono=
 crashes/runs out of battery after receiving the message from the modem dri=
ver the message is lost. There is no provision in the SMS modem API to sign=
al back to the modem driver that the message has been successfully stored o=
n the APE.

Cheers,
Waldo

--===============1848393035169339735==--

