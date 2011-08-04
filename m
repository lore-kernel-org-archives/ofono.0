Content-Type: multipart/mixed; boundary="===============7558046476029321621=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] speedup: blacklist the NO CARRIER terminator for control
 channel
Date: Thu, 04 Aug 2011 18:17:33 +0200
Message-ID: <1312474654.3373.39.camel@aeonflux>
In-Reply-To: <1312474385-6381-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7558046476029321621==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

> Some Speedup cards will send the NO CARRIER in the control channel.

please include a trace. I am not sure how this effect anything since we
are not supporting online/offline mode with these cards.

Regards

Marcel



--===============7558046476029321621==--

