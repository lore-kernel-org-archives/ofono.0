Content-Type: multipart/mixed; boundary="===============8377437959046401184=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] simauth: fix gsmAuthenticate
Date: Tue, 02 Oct 2018 17:57:36 -0500
Message-ID: <927f3df4-09f9-03ac-f471-01c028fc06e6@gmail.com>
In-Reply-To: <20181002224151.12385-1-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8377437959046401184==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/02/2018 05:41 PM, James Prestwood wrote:
> The input to the comp128 algorithm was relying on QSTRING_TO_BUF
> returning a pointer to persistant memory. This was not the case
> as it was returning a pointer to an intermediate object which was
> being freed once out of scope. It just happened to work most of
> the time. This change copies ki/rand into a static buffer.
> ---
>   src/simauth.cpp | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============8377437959046401184==--

