Content-Type: multipart/mixed; boundary="===============7852784198705688948=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/7] hfp_hf_bluez5: Handle org.bluez.Profile1.Cancel()
Date: Thu, 12 Sep 2013 13:21:01 -0500
Message-ID: <5232060D.7070302@gmail.com>
In-Reply-To: <1378858186-683-6-git-send-email-vcgomes@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7852784198705688948==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 09/10/2013 07:09 PM, Vinicius Costa Gomes wrote:
> Cancel() will be called when the ConnectProfile() is called, perhaps
> even replied with a success, and the user cancels the connection
> attempt.
> ---
>   plugins/hfp_hf_bluez5.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>

Since BlueZ removed the Cancel method from the profile implementation, =

I've removed it as well in commit 62c2b81db78eb32de0be9c3a809ddbf27b6e1c32.

Regards,
-Denis

--===============7852784198705688948==--

