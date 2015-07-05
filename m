Content-Type: multipart/mixed; boundary="===============3752738643379395810=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Handle NW DETACH and ME DETACH
Date: Sun, 05 Jul 2015 05:53:09 -0500
Message-ID: <55990C95.6040205@gmail.com>
In-Reply-To: <1435913014-22733-1-git-send-email-marko.sulejic@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3752738643379395810==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marko,

On 07/03/2015 03:43 AM, Marko Sulejic wrote:
> From: August Mayer <august.mayer@hale.at>
>
>   * According to the Telit AT reference, NW DETACH and ME DETACH
>     imply network deactivation.

Can you please include some description of why this patch is needed? =

E.g. what exceptional conditions is this supposed to be taking care of. =

  If it is Telit specific, then it should be behind logic testing for =

the TELIT vendor quirk.

Also, do realize that PPP session will be terminated by via LCP or by =

using the NO CARRIER final result code.  This logic is (in theory at =

least) redundant.

Regards,
-Denis

--===============3752738643379395810==--

