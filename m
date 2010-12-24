Content-Type: multipart/mixed; boundary="===============3534801141163601056=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] n900: remove unneeded g_isi_client_destroy call.
Date: Thu, 23 Dec 2010 18:26:10 -0600
Message-ID: <4D13E8A2.4050606@gmail.com>
In-Reply-To: <1293079181-13648-2-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3534801141163601056==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 12/22/2010 10:39 PM, Andrzej Zaborowski wrote:
> "client" is either NULL or uninitialised in this place.
> ---
>  plugins/n900.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============3534801141163601056==--

