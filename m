Content-Type: multipart/mixed; boundary="===============5162967353853882600=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: PPP broken by 6fc119d9eaee5f9cc37a5a7198d1c55ef98fd645
Date: Fri, 04 Jan 2019 16:22:44 +0100
Message-ID: <b7e415c0-e006-ebad-8d10-387b8a2b2916@geanix.com>
In-Reply-To: <CAKSBH7HcbAF=-APHV7O-C7a6ZnFegCPJtkf4Li6rqG7VG7kLmw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5162967353853882600==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 04/01/2019 15.48, Giacinto Cifelli wrote:
>> On 04/01/2019, Giacinto Cifelli <gciofono@gmail.com> wrote:
>>>> The comments for a88662d23c45f49d9af5a508d4d0a778950b2420 made me
>>>> suspect it is this part of the patch that broke it:
>>>>
>>>> diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
>>>> index df9cd0ef..3fe38217 100644
>>>> --- a/gatchat/ppp_lcp.c
>>>> +++ b/gatchat/ppp_lcp.c
>>>> @@ -279,6 +279,9 @@ static enum rcr_result lcp_rcr(struct pppcp_data
>>>> *pppcp,
>>>>                                  *new_len =3D 4;
>>>>
>>>>                                  return RCR_NAK;
>>>> +
>>>> +                       case G_AT_PPP_AUTH_METHOD_NONE:
>>>> +                               return RCR_REJECT;
> =

> can you change your code to:
>       return RCR_ACCEPT;
> =

> this is what I posted in the first attempt to commit, but Denis
> objected that a reject would be in order.
> I still believe that an accept would select as before the default
> operation at the end of the function, which is just... return
> RCR_ACCEPT; (line 354 on the latest commit as of today)
> =

> If this works, I can submit a new patch, or you can do it.

It doesn't work, because the early return skips the call to =

ppp_set_auth() in the last switch block.

Calling the function before returning works though:

diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
index 3fe38217..4aa63207 100644
--- a/gatchat/ppp_lcp.c
+++ b/gatchat/ppp_lcp.c
@@ -281,7 +281,8 @@ static enum rcr_result lcp_rcr(struct pppcp_data *pppcp,
                                 return RCR_NAK;

                         case G_AT_PPP_AUTH_METHOD_NONE:
-                               return RCR_REJECT;
+                               ppp_set_auth(ppp, =

ppp_option_iter_get_data(&iter));
+                               return RCR_ACCEPT;
                         }
                         break;
                 }



// Martin

--===============5162967353853882600==--

