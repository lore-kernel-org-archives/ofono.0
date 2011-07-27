Content-Type: multipart/mixed; boundary="===============2921466783100469693=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 3/4] atmodem: Add a polling based on CPIN query to detect
 SIM state change
Date: Wed, 27 Jul 2011 16:19:14 +0200
Message-ID: <1311776355.8920.71.camel@aeonflux>
In-Reply-To: <1311351329-1241-4-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2921466783100469693==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

> On ZTE/Speedup modem, AT+CPIN? keeps returning CME ERROR 14 for a moment
> after successful AT+CPIN=3D".."
> As there is no card status notification, a pooling with CPIN queries is u=
sed
> to detect the state change.

why don't we do this as part of the modem plugin and make it part of the
modem enabling call with the provided at_util_sim_state_query_new
function.

A dongle with a SIM card then just fails to get enabled. And that seems
pretty much fine to me.

Regards

Marcel



--===============2921466783100469693==--

