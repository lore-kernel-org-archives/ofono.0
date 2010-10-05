Content-Type: multipart/mixed; boundary="===============4429297838790807327=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] TODO: ofono_sim_ready_notify()
Date: Tue, 05 Oct 2010 17:59:01 +0200
Message-ID: <1286294341.2588.6.camel@aeonflux>
In-Reply-To: <1286293768-23460-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4429297838790807327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> ---
>  TODO |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

I applied this patch.

However you do remember that we had issues when we tried this the first
time. It looked simpler on paper then it was when trying to make this
work with all modem plugins. Remember that this has to work with all
modem plugins and not just ISI or IFX for that matter.

Regards

Marcel



--===============4429297838790807327==--

