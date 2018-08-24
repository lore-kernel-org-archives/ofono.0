Content-Type: multipart/mixed; boundary="===============7231036037567551174=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] udevng: fix removal of serial devices
Date: Fri, 24 Aug 2018 11:27:05 -0500
Message-ID: <d012b583-593c-3826-50a6-42a362f283e8@gmail.com>
In-Reply-To: <20180824113330.9735-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7231036037567551174==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 08/24/2018 06:33 AM, Martin Hundeb=C3=B8ll wrote:
> Since the merge of udev.c into udevng.c all cleanup function must handle
> both usb devices and serial devices. Add this distinction to
> check_remove(), so that is doesn't try to iterate the .serial member as
> if it were a .devices list.
> ---
>   plugins/udevng.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============7231036037567551174==--

