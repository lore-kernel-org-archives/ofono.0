Content-Type: multipart/mixed; boundary="===============3785820625907760640=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] Added SQLite history plugin
Date: Wed, 07 Apr 2010 12:33:50 -0500
Message-ID: <201004071233.50561.denkenz@gmail.com>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C9C1410FA5@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3785820625907760640==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Waldo,

> > Hi Denis,
> >
> > Actually our apps listen for the IncomingMessage signal, and store the
> > SMS in an internal database.
> > At some point by design, a restart, a crash or other reasons, it may
> > happen that apps are down while ofono and the modem are up, in that
> > case we lose incoming messages.
> =

> A similar lack of robustness exists at the modem API side as well, if oFo=
no
>  crashes/runs out of battery after receiving the message from the modem
>  driver the message is lost. There is no provision in the SMS modem API to
>  signal back to the modem driver that the message has been successfully
>  stored on the APE.

If oFono crashes/runs out of battery here the driver is gone along with oFo=
no.  =

Notifying it of anything is not going to help ;)

Regards,
-Denis

--===============3785820625907760640==--

