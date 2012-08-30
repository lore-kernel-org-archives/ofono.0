Content-Type: multipart/mixed; boundary="===============2374568882840670411=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC v1] gatchat: Print error message if opening tun failes
Date: Thu, 30 Aug 2012 17:07:21 -0500
Message-ID: <503FE419.3050908@gmail.com>
In-Reply-To: <1345810599-22871-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2374568882840670411==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On 08/24/2012 07:16 AM, Daniel Wagner wrote:
> From: Daniel Wagner<daniel.wagner@bmw-carit.de>
>
> This is a very common misstake. Let's help the users to
> configure their system correctly.
> ---
> Hi,
>
> I was not able to find out why the check in at_grps_context_prope() does =
not
> hit when the tun module is not loaded. Therefore, this on gets only
> an RFC state...
>
> cheers,
> daniel
>
>   gatchat/ppp_net.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>

I went ahead and applied this patch, thanks.

Regards,
-Denis


--===============2374568882840670411==--

