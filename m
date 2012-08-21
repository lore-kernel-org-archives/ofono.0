Content-Type: multipart/mixed; boundary="===============8116437712143326947=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC] gatchat: Print error message if opening tun failes
Date: Tue, 21 Aug 2012 14:34:05 -0500
Message-ID: <5033E2AD.7040300@gmail.com>
In-Reply-To: <5033A495.70509@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8116437712143326947==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On 08/21/2012 10:09 AM, Daniel Wagner wrote:
> Hi Marcel,
>
> [sorry, a resend, ofono doesn't like non subscriber to post]
>
> On 21.08.2012 15:00, Marcel Holtmann wrote:
>>> This is a very common misstake. Let's help the users to
>>> configure their system correctly.
>>> ---
>>> gatchat/ppp_net.c | 6 +++++-
>>> 1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/gatchat/ppp_net.c b/gatchat/ppp_net.c
>>> index 1609b99..7082de7 100644
>>> --- a/gatchat/ppp_net.c
>>> +++ b/gatchat/ppp_net.c
>>> @@ -155,8 +155,12 @@ struct ppp_net *ppp_net_new(GAtPPP *ppp, int fd)
>>> if (fd < 0) {
>>> /* open a tun interface */
>>> fd =3D open("/dev/net/tun", O_RDWR);
>>> - if (fd < 0)
>>> + if (fd < 0) {
>>> + fprintf(stderr, "Couldn't open tun device. "
>>> + "Do you run oFono as root and do you "
>>> + "have the TUN module loaded?");
>>
>> really, stderr?
>
> I was not sure what 'channel' to use to report something from gatchat.
> Would g_print() be the right choice?
>

ppp_debug would be best

>>> goto error;
>>> + }
>>>
>>> ifr.ifr_flags =3D IFF_TUN | IFF_NO_PI;
>>> strcpy(ifr.ifr_name, "ppp%d");
>>
>> Aren't the atom drivers checking this case for you?
>
> I don't know, but I had the exactly the same problem and I am pretty
> sure that there was not log entry in any kind. If there is better place
> to add such a log entry, I happy to send a patch.
>

There is a check for TUN inside drivers/atmodem/gprs-context.c =

at_gprs_context_probe().  Why it isn't being triggered I do not know.

Regards,
-Denis

--===============8116437712143326947==--

