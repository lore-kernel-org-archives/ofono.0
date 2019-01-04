Content-Type: multipart/mixed; boundary="===============8954426836494931147=="
MIME-Version: 1.0
From: Philippe De Swert <philippedeswert@gmail.com>
Subject: Re: PPP broken by 6fc119d9eaee5f9cc37a5a7198d1c55ef98fd645
Date: Fri, 04 Jan 2019 16:40:14 +0200
Message-ID: <CAPsFW+SnOenGf+qcfujLK43b0WPHrQDTdu=ecyncwO1-YXnS-A@mail.gmail.com>
In-Reply-To: <CAKSBH7E+jaBNUVv8BzaK=SifqhDEqMrLh9pXzpvZoBUgXixh6g@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8954426836494931147==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

Thanks for looking at this so quickly!

On 04/01/2019, Giacinto Cifelli <gciofono@gmail.com> wrote:
>> The comments for a88662d23c45f49d9af5a508d4d0a778950b2420 made me
>> suspect it is this part of the patch that broke it:
>>
>> diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
>> index df9cd0ef..3fe38217 100644
>> --- a/gatchat/ppp_lcp.c
>> +++ b/gatchat/ppp_lcp.c
>> @@ -279,6 +279,9 @@ static enum rcr_result lcp_rcr(struct pppcp_data
>> *pppcp,
>>                                 *new_len =3D 4;
>>
>>                                 return RCR_NAK;
>> +
>> +                       case G_AT_PPP_AUTH_METHOD_NONE:
>> +                               return RCR_REJECT;
>
> I remember this, I added it because of a suggestion that couldn't just
> ignore it.
> Is your PDP context configured for AUTH_NONE, PAP or CHAP?

AUTH_NONE.

> And what happens if you change it?

It took me a while to understand this was the issue as I had another
sim who would request CHAP and that one worked (even if it was empty
username and pass, operators are weird..)

So from what I have seen I would say the issue is only with AUTH_NONE.
Most likely RCR_REJECT is the wrong thing to send, but my knowledge of
PPP is basically whatever I read today and a quick look at the RFC so
I am not in a position to comment in more detail on that. What I do
know is that removing that bit made it work for me.

Cheers,

Philippe

--===============8954426836494931147==--

