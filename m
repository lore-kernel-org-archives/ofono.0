Content-Type: multipart/mixed; boundary="===============8894447176904588067=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Bj=C3=B8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH 3/3] Add support for Sierra MC73xx QMI modems
Date: Mon, 02 May 2016 22:24:38 +0200
Message-ID: <87a8k8p5rt.fsf@nemi.mork.no>
In-Reply-To: <1462200163-15827-3-git-send-email-m.chaplet@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8894447176904588067==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Martin Chaplet <m.chaplet@kerlink.fr> writes:

> +# Sierra MC73xx (wwan0 is buggy,

I suspect this is a raw-ip vs 802.3 issue. For example: wwan0 might be
configured for raw-ip if firmware autoconnect is enabled. You should be
able to detect this with a QMI_WDA "Get Data Format" request.

In general, both interfaces 8 and 10 are usable on these modems.



Bj=C3=B8rn

--===============8894447176904588067==--

