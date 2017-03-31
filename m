Content-Type: multipart/mixed; boundary="===============9044752102415052120=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC hwdb v1 26/28] udevng: remove 'option' driver setup
Date: Fri, 31 Mar 2017 18:18:10 -0500
Message-ID: <1b0a02de-b51a-1bb5-5f07-c3eece650018@gmail.com>
In-Reply-To: <20170330205309.25850-27-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9044752102415052120==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/30/2017 03:53 PM, Jonas Bonn wrote:
> No driver named 'option' exists so this device can never be instantiated.
> ---
>  plugins/udevng.c | 34 ----------------------------------
>  1 file changed, 34 deletions(-)
>

I applied this one.  All Option devices should be handled by hso.  Not =

sure why this one was still around.

Regards,
-Denis


--===============9044752102415052120==--

