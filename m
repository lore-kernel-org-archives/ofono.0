Content-Type: multipart/mixed; boundary="===============8445562366855942427=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC sim-ready-v0 PATCH 2/3] atmodem/sim: use
 ofono_sim_ready_notify
Date: Tue, 05 Oct 2010 18:45:56 +0200
Message-ID: <1286297156.2588.8.camel@aeonflux>
In-Reply-To: <1286294661-24300-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8445562366855942427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> The ofono_sim_driver->query_passwd_state callback will return
> OFONO_SIM_PASSWORD_INVALID if SIM is not really ready yet. When the sim
> gets ready or timeout occurs, ofono_sim_ready_notify() is called.

this reminds me that the current quirks won't work when entering the
PUK. The only thing hat has been working is when entering the PIN and
waiting for a SIM ready signal. When the PUK is required our code path
is different and it also needs to do the SIM ready notification. You
might wanna have a look into that as well.

Regards

Marcel



--===============8445562366855942427==--

