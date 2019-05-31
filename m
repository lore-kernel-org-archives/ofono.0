Content-Type: multipart/mixed; boundary="===============3478665500962062125=="
MIME-Version: 1.0
From: Philippe De Swert <philippedeswert@gmail.com>
Subject: Re: [PATCH] ppp: Allow to set-up ppp connection without
 authentification
Date: Fri, 31 May 2019 12:51:00 +0300
Message-ID: <CAPsFW+Ty+qJwOZp+GSjbwxrW1eU_UfDsNtOGQNdxk-v=bywjgg@mail.gmail.com>
In-Reply-To: <ca4656c1-5506-93bd-26da-5c497d6c1970@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3478665500962062125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hei Denis,

On 30/05/2019, Denis Kenzior <denkenz@gmail.com> wrote:
>> --- a/gatchat/ppp_lcp.c
>> +++ b/gatchat/ppp_lcp.c
>> @@ -281,7 +281,7 @@ static enum rcr_result lcp_rcr(struct pppcp_data
>> *pppcp,
>>   				return RCR_NAK;
>>
>>   			case G_AT_PPP_AUTH_METHOD_NONE:
>> -				return RCR_REJECT;
>> +				break;
>
> What this in effect does is ignore whatever setting we told GAtPPP to
> use and uses the one from the server.  You're effectively doing what I
> suggested in
> https://lists.ofono.org/pipermail/ofono/2019-January/019074.html but in
> a "lets hack this until it works for me" kind of way.

Sorry I missed that comment. Will need to dig a bit to understand what
you mean. I just wanted to revive this as probably many people could
potentially be running into this issue and discussion just stopped
earlier.

> Essentially it seems that your firmware blindly negotiates CHAP even
> though it has no intention of actually using it.  So just tell GAtPPP
> that it should configure itself for CHAP and be done with it instead of
> trying to set G_AT_PPP_AUTH_METHOD_NONE.
>
> Maybe we should just revert that patch completely instead and force PPP
> based drivers to always use CHAP even if no authentication is
> configured, the way it used to be.
>

Might be an option too, anyway the important thing is that this gets
fixed. I'll dig into it again a bit when I have time.

Cheers,

Philippe

--===============3478665500962062125==--

