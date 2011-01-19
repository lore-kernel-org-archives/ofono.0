Content-Type: multipart/mixed; boundary="===============4963855835309417946=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH v3] bluetooth: Add reference count for bluetooth utils
Date: Wed, 19 Jan 2011 10:57:28 -0200
Message-ID: <20110119125728.GA11083@joana>
In-Reply-To: <1295435871-3462-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4963855835309417946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

* Fr=C3=A9d=C3=A9ric Danis <frederic.danis@linux.intel.com> [2011-01-19 1=
2:17:51 +0100]:

> Add bluetooth_ref()/bluetooth_unref() to support reference count in
> bluetooth utils.
> ---
>  plugins/bluetooth.c |   59 ++++++++++++++++++++++++++++++++++++++-------=
------
>  1 files changed, 44 insertions(+), 15 deletions(-)

Acked.

-- =

Gustavo F. Padovan
http://profusion.mobi

--===============4963855835309417946==--

