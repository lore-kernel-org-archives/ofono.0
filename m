Content-Type: multipart/mixed; boundary="===============0493213757547313879=="
MIME-Version: 1.0
From: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [RFC v0 00/11] External HFP Profile
Date: Fri, 23 Nov 2012 13:43:06 +0200
Message-ID: <20121123114306.GA10157@x220.ger.corp.intel.com>
In-Reply-To: <1353606808-25032-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0493213757547313879==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On Thu, Nov 22, 2012, Claudio Takahasi wrote:
> BlueZ supports now external profile registration, see:
> bluez/doc/profile-api.txt
> =

> This patch series has the initial implementation of the HFP external
> profile in oFono. HandsfreeAgent and HandsfreeGateway interfaces were
> removed from BlueZ.

I also got this weirdness:

ofonod[9813]: plugins/hfp_hf.c:profile_new_connection() Profile handler New=
Connection
ofonod[9813]: plugins/hfp_hf.c:profile_new_connection() /org/bluez/hci0/dev=
_70_F9_27_18_1F_B9: doesn't support HFP

Which seems to be from the following set of code in
profile_new_connection():

	hfp_data =3D g_hash_table_lookup(hfp_hash, device);
	if (hfp_data =3D=3D NULL) {
		DBG("%s: doesn't support HFP", device);
		goto error;
	}

You can't rely on SDP having been completed by the time there's an
incoming HFP connection. This is a very likely scenario when the remote
initiates the connection. In such a case the mere fact that the remote
has connected HFP to us *is* the proof that the remote supports HFP and
you should just accept such connection attempts.

Johan

--===============0493213757547313879==--

