Content-Type: multipart/mixed; boundary="===============2174901693661462427=="
MIME-Version: 1.0
From: Anibal =?unknown-8bit?q?Lim=C3=B3n?= <limon.anibal@gmail.com>
Subject: Re: Telit ME910C1-WW not detected
Date: Thu, 27 Feb 2020 09:38:42 -0600
Message-ID: <CAPS-YPCNiEJMOMCm7p0gHg+51mvJgaDJx1bUr+W05MP2zLmpJw@mail.gmail.com>
In-Reply-To: <CABPh3UP1bYPJRDjJwtR1nZxAXSmFNxS+mDfTZx4mRvKOO7hcDg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2174901693661462427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2020 at 5:49 AM nick83ola <nick83ola@gmail.com> wrote:

> Hi Anibal,
> I was dragged in other things and I forgot to respond to you.
> When I was in the US I had some issue with the network provider ->
> they hadn't registered the sim for the right area where i was testing
> it ->
> so I couldn't test this patch thoroughly.
>

Hi Nicola,

One possible scenario could be that the Network provided settings (MCC,
MNC) aren't in the mobile database information,
I have experience this with a SIM of a customer that uses a custom network
settings.

Regards,
Anibal



>
> If there's anyone there with a telit ME910C1 in the US could be very
> helpful if we can test this through.
> From what I've seen the modem is recognized and when I did the test
> from remote with the right SIM it was working fine.
> But I didn't test the auto-attach patch and now we switched for the
> moment to another modem so I'm not in the condition of testing this.
>
> Cheers
> Nicola Lunghi
>
>
> On Mon, 21 Oct 2019 at 13:45, nick83ola <nick83ola@gmail.com> wrote:
> >
> > Hi Anibal,
> >
> > Sorry but i was dragged along with other tasks and didn't test this
> througly.
> > Next week I will be in the US (I am based in Ireland) to do some
> > testing on the reliability of ME910
> > and I will be able to thoroughly test this.
> > For now (from remote) it seems to be working fine but next week I will
> > have more information on this
> >
> > Thanks for your patience
> > Nicola Lunghi
> >
> > On Thu, 3 Oct 2019 at 23:09, Anibal Lim=C3=B3n <limon.anibal@gmail.co=
m>
> wrote:
> > >
> > > Hi,
> > >
> > > I fix a bug in the code due to auto-attach, see [1] and the specific
> change [2].
> > > Please test and let me know before send the patch.
> > >
> > > Cheers.
> > > Anibal
> > >
> > > [1] https://github.com/alimon/ofono/tree/me910_fix_v2
> > > [2]
> https://github.com/alimon/ofono/commit/682fd656afaf637b915d5d6b78a4211dd6=
e0884d
> > >
> > > On Wed, Oct 2, 2019 at 9:39 AM Anibal Lim=C3=B3n <limon.anibal@gmai=
l.com>
> wrote:
> > >>
> > >>
> > >>
> > >> On Wed, Oct 2, 2019 at 9:32 AM nick83ola <nick83ola@gmail.com> wro=
te:
> > >>>
> > >>> Thanks
> > >>>
> > >>> do you think that you can submit it to ofono mailing list?
> > >>>
> > >>> in particular I don;t know if
> > >>>
> > >>> if (data->model =3D=3D ME910C1)
> > >>> ofono_netreg_create(modem, OFONO_VENDOR_TELIT_ME910C1, "atmodem",
> data->chat);
> > >>> else
> > >>> ofono_netreg_create(modem, OFONO_VENDOR_TELIT, "atmodem",
> data->chat);
> > >>
> > >>
> > >> That's because this specific model dosen't support  signal strength
> reporting via CIND.
> > >>
> > >>
> https://github.com/alimon/ofono/commit/920712e184ffaf1143e9ce13c3bec8ac1d=
eeda5c#diff-2bbda16023120e26f58cfa7335520fb4
> > >>
> > >> Anibal
> > >>
> > >>>
> > >>>
> > >>> is acceptable
> > >>>
> > >>> Cheers
> > >>> Nicola Lunghi
> > >>>
> > >>>
> > >>> On Wed, 2 Oct 2019 at 15:29, Anibal Lim=C3=B3n <limon.anibal@gmai=
l.com>
> wrote:
> > >>>>
> > >>>>
> > >>>>
> > >>>> On Wed, Oct 2, 2019 at 9:00 AM nick83ola <nick83ola@gmail.com>
> wrote:
> > >>>>>
> > >>>>> Hi Anibal,
> > >>>>> I'm interested as well in the patch
> > >>>>>
> > >>>>> I saw that there you have two branches (me910 and v1.30+me910) can
> you tell me what branch have you tested?
> > >>>>> the diff is this
> > >>>>
> > >>>>
> > >>>> Yeah the latest one is me910, I was making a mistake to enable GPRS
> instead of disable it, that's the change.
> > >>>>
> > >>>> Anibal
> > >>>>
> > >>>>>
> > >>>>>
> > >>>>> git diff me910
> > >>>>> diff --git a/plugins/telit.c b/plugins/telit.c
> > >>>>> index f36995dc..50344281 100644
> > >>>>> --- a/plugins/telit.c
> > >>>>> +++ b/plugins/telit.c
> > >>>>> @@ -239,16 +239,19 @@ static void cfun_enable_cb(gboolean ok,
> GAtResult *result, gpointer user_data)
> > >>>>>
> > >>>>>         ofono_modem_set_powered(modem, TRUE);
> > >>>>>
> > >>>>> -       /*
> > >>>>> -        * Tell the modem not to automatically initiate auto-atta=
ch
> > >>>>> -        * proceedures on its own.
> > >>>>> -        */
> > >>>>> -       if (data->model =3D=3D ME910C1)
> > >>>>> -               g_at_chat_send(data->chat, "AT+CGATT=3D0", NULL,
> NULL, NULL, NULL);
> > >>>>> -       else
> > >>>>> -
> > >>>>> +       if (data->model =3D=3D ME910C1) {
> > >>>>> +               /*
> > >>>>> +                * Telit ME910C1 needs to activate the GPRS to
> auto-attach the network.
> > >>>>> +                */
> > >>>>> +               g_at_chat_send(data->chat, "AT+CGATT=3D1", NULL,
> NULL, NULL, NULL);
> > >>>>> +       } else {
> > >>>>> +               /*
> > >>>>> +                * Tell the modem not to automatically initiate
> auto-attach
> > >>>>> +                * proceedures on its own.
> > >>>>> +                */
> > >>>>>                 g_at_chat_send(data->chat, "AT#AUTOATT=3D0",
> none_prefix,
> > >>>>>                                         NULL, NULL, NULL);
> > >>>>> +       }
> > >>>>>
> > >>>>>         /* Follow sim state */
> > >>>>>         g_at_chat_register(data->chat, "#QSS:", telit_qss_notify,
> > >>>>>
> > >>>>>
> > >>>>> Thanks
> > >>>>> Nicola Lunghi
> > >>>>>
> > >>>>>
> > >>>>> On Tue, 1 Oct 2019 at 22:54, <limon.anibal@gmail.com> wrote:
> > >>>>>>
> > >>>>>> Hi Dresdo,
> > >>>>>>
> > >>>>>> I have a patch that adds support for Telit ME910 but it is upon
> Ofono 1.30, i plan to send for review.
> > >>>>>>
> > >>>>>>
> https://github.com/alimon/ofono/commit/920712e184ffaf1143e9ce13c3bec8ac1d=
eeda5c
> > >>>>>>
> > >>>>>> Regards!,
> > >>>>>> Anibal
> > >>>>>> _______________________________________________
> > >>>>>> ofono mailing list -- ofono(a)ofono.org
> > >>>>>> To unsubscribe send an email to ofono-leave(a)ofono.org
>

--===============2174901693661462427==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFRodSwgRmVi
IDI3LCAyMDIwIGF0IDU6NDkgQU0gbmljazgzb2xhICZsdDs8YSBocmVmPSJtYWlsdG86bmljazgz
b2xhQGdtYWlsLmNvbSI+bmljazgzb2xhQGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rp
dj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAw
cHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1s
ZWZ0OjFleCI+SGkgQW5pYmFsLDxicj4KSSB3YXMgZHJhZ2dlZCBpbiBvdGhlciB0aGluZ3MgYW5k
IEkgZm9yZ290IHRvIHJlc3BvbmQgdG8geW91Ljxicj4KV2hlbiBJIHdhcyBpbiB0aGUgVVMgSSBo
YWQgc29tZSBpc3N1ZSB3aXRoIHRoZSBuZXR3b3JrIHByb3ZpZGVyIC0mZ3Q7PGJyPgp0aGV5IGhh
ZG4mIzM5O3QgcmVnaXN0ZXJlZCB0aGUgc2ltIGZvciB0aGUgcmlnaHQgYXJlYSB3aGVyZSBpIHdh
cyB0ZXN0aW5nPGJyPgppdCAtJmd0Ozxicj4Kc28gSSBjb3VsZG4mIzM5O3QgdGVzdCB0aGlzIHBh
dGNoIHRob3JvdWdobHkuPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PkhpIE5p
Y29sYSw8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pk9uZSBwb3NzaWJsZSBzY2VuYXJpbyBjb3Vs
ZCBiZSB0aGF0IHRoZSBOZXR3b3JrIHByb3ZpZGVkIHNldHRpbmdzIChNQ0MsIE1OQykgYXJlbiYj
Mzk7dCBpbiB0aGUgbW9iaWxlIGRhdGFiYXNlIGluZm9ybWF0aW9uLDwvZGl2PjxkaXY+SSBoYXZl
IGV4cGVyaWVuY2UgdGhpcyB3aXRoIGEgU0lNIG9mIGEgY3VzdG9tZXIgdGhhdCB1c2VzIGEgY3Vz
dG9tIG5ldHdvcmsgc2V0dGluZ3MuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5SZWdhcmRzLDwv
ZGl2PjxkaXY+QW5pYmFsPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj7CoDwvZGl2PjxibG9ja3F1
b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDti
b3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4K
PGJyPgpJZiB0aGVyZSYjMzk7cyBhbnlvbmUgdGhlcmUgd2l0aCBhIHRlbGl0IE1FOTEwQzEgaW4g
dGhlIFVTIGNvdWxkIGJlIHZlcnk8YnI+CmhlbHBmdWwgaWYgd2UgY2FuIHRlc3QgdGhpcyB0aHJv
dWdoLjxicj4KRnJvbSB3aGF0IEkmIzM5O3ZlIHNlZW4gdGhlIG1vZGVtIGlzIHJlY29nbml6ZWQg
YW5kIHdoZW4gSSBkaWQgdGhlIHRlc3Q8YnI+CmZyb20gcmVtb3RlIHdpdGggdGhlIHJpZ2h0IFNJ
TSBpdCB3YXMgd29ya2luZyBmaW5lLjxicj4KQnV0IEkgZGlkbiYjMzk7dCB0ZXN0IHRoZSBhdXRv
LWF0dGFjaCBwYXRjaCBhbmQgbm93IHdlIHN3aXRjaGVkIGZvciB0aGU8YnI+Cm1vbWVudCB0byBh
bm90aGVyIG1vZGVtIHNvIEkmIzM5O20gbm90IGluIHRoZSBjb25kaXRpb24gb2YgdGVzdGluZyB0
aGlzLjxicj4KPGJyPgpDaGVlcnM8YnI+Ck5pY29sYSBMdW5naGk8YnI+Cjxicj4KPGJyPgpPbiBN
b24sIDIxIE9jdCAyMDE5IGF0IDEzOjQ1LCBuaWNrODNvbGEgJmx0OzxhIGhyZWY9Im1haWx0bzpu
aWNrODNvbGFAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+bmljazgzb2xhQGdtYWlsLmNvbTwv
YT4mZ3Q7IHdyb3RlOjxicj4KJmd0Ozxicj4KJmd0OyBIaSBBbmliYWwsPGJyPgomZ3Q7PGJyPgom
Z3Q7IFNvcnJ5IGJ1dCBpIHdhcyBkcmFnZ2VkIGFsb25nIHdpdGggb3RoZXIgdGFza3MgYW5kIGRp
ZG4mIzM5O3QgdGVzdCB0aGlzIHRocm91Z2x5Ljxicj4KJmd0OyBOZXh0IHdlZWsgSSB3aWxsIGJl
IGluIHRoZSBVUyAoSSBhbSBiYXNlZCBpbiBJcmVsYW5kKSB0byBkbyBzb21lPGJyPgomZ3Q7IHRl
c3Rpbmcgb24gdGhlIHJlbGlhYmlsaXR5IG9mIE1FOTEwPGJyPgomZ3Q7IGFuZCBJIHdpbGwgYmUg
YWJsZSB0byB0aG9yb3VnaGx5IHRlc3QgdGhpcy48YnI+CiZndDsgRm9yIG5vdyAoZnJvbSByZW1v
dGUpIGl0IHNlZW1zIHRvIGJlIHdvcmtpbmcgZmluZSBidXQgbmV4dCB3ZWVrIEkgd2lsbDxicj4K
Jmd0OyBoYXZlIG1vcmUgaW5mb3JtYXRpb24gb24gdGhpczxicj4KJmd0Ozxicj4KJmd0OyBUaGFu
a3MgZm9yIHlvdXIgcGF0aWVuY2U8YnI+CiZndDsgTmljb2xhIEx1bmdoaTxicj4KJmd0Ozxicj4K
Jmd0OyBPbiBUaHUsIDMgT2N0IDIwMTkgYXQgMjM6MDksIEFuaWJhbCBMaW3Ds24gJmx0OzxhIGhy
ZWY9Im1haWx0bzpsaW1vbi5hbmliYWxAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+bGltb24u
YW5pYmFsQGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj4KJmd0OyAmZ3Q7PGJyPgomZ3Q7ICZn
dDsgSGksPGJyPgomZ3Q7ICZndDs8YnI+CiZndDsgJmd0OyBJIGZpeCBhIGJ1ZyBpbiB0aGUgY29k
ZSBkdWUgdG8gYXV0by1hdHRhY2gsIHNlZSBbMV0gYW5kIHRoZSBzcGVjaWZpYyBjaGFuZ2UgWzJd
Ljxicj4KJmd0OyAmZ3Q7IFBsZWFzZSB0ZXN0IGFuZCBsZXQgbWUga25vdyBiZWZvcmUgc2VuZCB0
aGUgcGF0Y2guPGJyPgomZ3Q7ICZndDs8YnI+CiZndDsgJmd0OyBDaGVlcnMuPGJyPgomZ3Q7ICZn
dDsgQW5pYmFsPGJyPgomZ3Q7ICZndDs8YnI+CiZndDsgJmd0OyBbMV0gPGEgaHJlZj0iaHR0cHM6
Ly9naXRodWIuY29tL2FsaW1vbi9vZm9uby90cmVlL21lOTEwX2ZpeF92MiIgcmVsPSJub3JlZmVy
cmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9naXRodWIuY29tL2FsaW1vbi9vZm9uby90cmVl
L21lOTEwX2ZpeF92MjwvYT48YnI+CiZndDsgJmd0OyBbMl0gPGEgaHJlZj0iaHR0cHM6Ly9naXRo
dWIuY29tL2FsaW1vbi9vZm9uby9jb21taXQvNjgyZmQ2NTZhZmFmNjM3YjkxNWQ1ZDZiNzhhNDIx
MWRkNmUwODg0ZCIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9naXRo
dWIuY29tL2FsaW1vbi9vZm9uby9jb21taXQvNjgyZmQ2NTZhZmFmNjM3YjkxNWQ1ZDZiNzhhNDIx
MWRkNmUwODg0ZDwvYT48YnI+CiZndDsgJmd0Ozxicj4KJmd0OyAmZ3Q7IE9uIFdlZCwgT2N0IDIs
IDIwMTkgYXQgOTozOSBBTSBBbmliYWwgTGltw7NuICZsdDs8YSBocmVmPSJtYWlsdG86bGltb24u
YW5pYmFsQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmxpbW9uLmFuaWJhbEBnbWFpbC5jb208
L2E+Jmd0OyB3cm90ZTo8YnI+CiZndDsgJmd0OyZndDs8YnI+CiZndDsgJmd0OyZndDs8YnI+CiZn
dDsgJmd0OyZndDs8YnI+CiZndDsgJmd0OyZndDsgT24gV2VkLCBPY3QgMiwgMjAxOSBhdCA5OjMy
IEFNIG5pY2s4M29sYSAmbHQ7PGEgaHJlZj0ibWFpbHRvOm5pY2s4M29sYUBnbWFpbC5jb20iIHRh
cmdldD0iX2JsYW5rIj5uaWNrODNvbGFAZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPgomZ3Q7
ICZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsgVGhhbmtzPGJyPgomZ3Q7ICZndDsm
Z3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsgZG8geW91IHRoaW5rIHRoYXQgeW91IGNhbiBz
dWJtaXQgaXQgdG8gb2Zvbm8gbWFpbGluZyBsaXN0Pzxicj4KJmd0OyAmZ3Q7Jmd0OyZndDs8YnI+
CiZndDsgJmd0OyZndDsmZ3Q7IGluIHBhcnRpY3VsYXIgSSBkb247dCBrbm93IGlmPGJyPgomZ3Q7
ICZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsgaWYgKGRhdGEtJmd0O21vZGVsID09
IE1FOTEwQzEpPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyBvZm9ub19uZXRyZWdfY3JlYXRlKG1vZGVt
LCBPRk9OT19WRU5ET1JfVEVMSVRfTUU5MTBDMSwgJnF1b3Q7YXRtb2RlbSZxdW90OywgZGF0YS0m
Z3Q7Y2hhdCk7PGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyBlbHNlPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0
OyBvZm9ub19uZXRyZWdfY3JlYXRlKG1vZGVtLCBPRk9OT19WRU5ET1JfVEVMSVQsICZxdW90O2F0
bW9kZW0mcXVvdDssIGRhdGEtJmd0O2NoYXQpOzxicj4KJmd0OyAmZ3Q7Jmd0Ozxicj4KJmd0OyAm
Z3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7Jmd0OyBUaGF0JiMzOTtzIGJlY2F1c2UgdGhpcyBzcGVjaWZp
YyBtb2RlbCBkb3NlbiYjMzk7dCBzdXBwb3J0wqAgc2lnbmFsIHN0cmVuZ3RoIHJlcG9ydGluZyB2
aWEgQ0lORC48YnI+CiZndDsgJmd0OyZndDs8YnI+CiZndDsgJmd0OyZndDsgPGEgaHJlZj0iaHR0
cHM6Ly9naXRodWIuY29tL2FsaW1vbi9vZm9uby9jb21taXQvOTIwNzEyZTE4NGZmYWYxMTQzZTlj
ZTEzYzNiZWM4YWMxZGVlZGE1YyNkaWZmLTJiYmRhMTYwMjMxMjBlMjZmNThjZmE3MzM1NTIwZmI0
IiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2dpdGh1Yi5jb20vYWxp
bW9uL29mb25vL2NvbW1pdC85MjA3MTJlMTg0ZmZhZjExNDNlOWNlMTNjM2JlYzhhYzFkZWVkYTVj
I2RpZmYtMmJiZGExNjAyMzEyMGUyNmY1OGNmYTczMzU1MjBmYjQ8L2E+PGJyPgomZ3Q7ICZndDsm
Z3Q7PGJyPgomZ3Q7ICZndDsmZ3Q7IEFuaWJhbDxicj4KJmd0OyAmZ3Q7Jmd0Ozxicj4KJmd0OyAm
Z3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyBp
cyBhY2NlcHRhYmxlPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsg
Q2hlZXJzPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyBOaWNvbGEgTHVuZ2hpPGJyPgomZ3Q7ICZndDsm
Z3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyZndDsmZ3Q7IE9uIFdl
ZCwgMiBPY3QgMjAxOSBhdCAxNToyOSwgQW5pYmFsIExpbcOzbiAmbHQ7PGEgaHJlZj0ibWFpbHRv
OmxpbW9uLmFuaWJhbEBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5saW1vbi5hbmliYWxAZ21h
aWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDs8YnI+CiZndDsg
Jmd0OyZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsm
Z3Q7Jmd0OyZndDsgT24gV2VkLCBPY3QgMiwgMjAxOSBhdCA5OjAwIEFNIG5pY2s4M29sYSAmbHQ7
PGEgaHJlZj0ibWFpbHRvOm5pY2s4M29sYUBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5uaWNr
ODNvbGFAZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsm
Z3Q7PGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7IEhpIEFuaWJhbCw8YnI+CiZndDsgJmd0
OyZndDsmZ3Q7Jmd0OyZndDsgSSYjMzk7bSBpbnRlcmVzdGVkIGFzIHdlbGwgaW4gdGhlIHBhdGNo
PGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsm
Z3Q7IEkgc2F3IHRoYXQgdGhlcmUgeW91IGhhdmUgdHdvIGJyYW5jaGVzIChtZTkxMCBhbmQgdjEu
MzArbWU5MTApIGNhbiB5b3UgdGVsbCBtZSB3aGF0IGJyYW5jaCBoYXZlIHlvdSB0ZXN0ZWQ/PGJy
PgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7IHRoZSBkaWZmIGlzIHRoaXM8YnI+CiZndDsgJmd0
OyZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsmZ3Q7
Jmd0OyZndDsgWWVhaCB0aGUgbGF0ZXN0IG9uZSBpcyBtZTkxMCwgSSB3YXMgbWFraW5nIGEgbWlz
dGFrZSB0byBlbmFibGUgR1BSUyBpbnN0ZWFkIG9mIGRpc2FibGUgaXQsIHRoYXQmIzM5O3MgdGhl
IGNoYW5nZS48YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsm
Z3Q7IEFuaWJhbDxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0
OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7PGJyPgomZ3Q7ICZndDsmZ3Q7
Jmd0OyZndDsmZ3Q7IGdpdCBkaWZmIG1lOTEwPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7
IGRpZmYgLS1naXQgYS9wbHVnaW5zL3RlbGl0LmMgYi9wbHVnaW5zL3RlbGl0LmM8YnI+CiZndDsg
Jmd0OyZndDsmZ3Q7Jmd0OyZndDsgaW5kZXggZjM2OTk1ZGMuLjUwMzQ0MjgxIDEwMDY0NDxicj4K
Jmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0OyAtLS0gYS9wbHVnaW5zL3RlbGl0LmM8YnI+CiZndDsg
Jmd0OyZndDsmZ3Q7Jmd0OyZndDsgKysrIGIvcGx1Z2lucy90ZWxpdC5jPGJyPgomZ3Q7ICZndDsm
Z3Q7Jmd0OyZndDsmZ3Q7IEBAIC0yMzksMTYgKzIzOSwxOSBAQCBzdGF0aWMgdm9pZCBjZnVuX2Vu
YWJsZV9jYihnYm9vbGVhbiBvaywgR0F0UmVzdWx0ICpyZXN1bHQsIGdwb2ludGVyIHVzZXJfZGF0
YSk8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0
OyZndDvCoCDCoCDCoCDCoCDCoG9mb25vX21vZGVtX3NldF9wb3dlcmVkKG1vZGVtLCBUUlVFKTs8
YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZn
dDsgLcKgIMKgIMKgIMKgLyo8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDsgLcKgIMKgIMKg
IMKgICogVGVsbCB0aGUgbW9kZW0gbm90IHRvIGF1dG9tYXRpY2FsbHkgaW5pdGlhdGUgYXV0by1h
dHRhY2g8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDsgLcKgIMKgIMKgIMKgICogcHJvY2Vl
ZHVyZXMgb24gaXRzIG93bi48YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDsgLcKgIMKgIMKg
IMKgICovPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7IC3CoCDCoCDCoCDCoGlmIChkYXRh
LSZndDttb2RlbCA9PSBNRTkxMEMxKTxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0OyAtwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBnX2F0X2NoYXRfc2VuZChkYXRhLSZndDtjaGF0LCAmcXVvdDtB
VCtDR0FUVD0wJnF1b3Q7LCBOVUxMLCBOVUxMLCBOVUxMLCBOVUxMKTs8YnI+CiZndDsgJmd0OyZn
dDsmZ3Q7Jmd0OyZndDsgLcKgIMKgIMKgIMKgZWxzZTxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7
Jmd0OyAtPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7ICvCoCDCoCDCoCDCoGlmIChkYXRh
LSZndDttb2RlbCA9PSBNRTkxMEMxKSB7PGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqIFRlbGl0IE1FOTEwQzEgbmVlZHMgdG8gYWN0aXZhdGUg
dGhlIEdQUlMgdG8gYXV0by1hdHRhY2ggdGhlIG5ldHdvcmsuPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0
OyZndDsmZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqLzxicj4KJmd0OyAmZ3Q7Jmd0OyZn
dDsmZ3Q7Jmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnX2F0X2NoYXRfc2VuZChkYXRhLSZn
dDtjaGF0LCAmcXVvdDtBVCtDR0FUVD0xJnF1b3Q7LCBOVUxMLCBOVUxMLCBOVUxMLCBOVUxMKTs8
YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDsgK8KgIMKgIMKgIMKgfSBlbHNlIHs8YnI+CiZn
dDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyo8YnI+CiZn
dDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICogVGVsbCB0
aGUgbW9kZW0gbm90IHRvIGF1dG9tYXRpY2FsbHkgaW5pdGlhdGUgYXV0by1hdHRhY2g8YnI+CiZn
dDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICogcHJvY2Vl
ZHVyZXMgb24gaXRzIG93bi48YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDsgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgICovPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBnX2F0X2NoYXRfc2VuZChkYXRhLSZndDtjaGF0LCAmcXVvdDtBVCNB
VVRPQVRUPTAmcXVvdDssIG5vbmVfcHJlZml4LDxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgTlVMTCwgTlVMTCwgTlVMTCk7PGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7ICvC
oCDCoCDCoCDCoH08YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyZn
dDsmZ3Q7Jmd0OyZndDvCoCDCoCDCoCDCoCDCoC8qIEZvbGxvdyBzaW0gc3RhdGUgKi88YnI+CiZn
dDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDvCoCDCoCDCoCDCoCDCoGdfYXRfY2hhdF9yZWdpc3Rlcihk
YXRhLSZndDtjaGF0LCAmcXVvdDsjUVNTOiZxdW90OywgdGVsaXRfcXNzX25vdGlmeSw8YnI+CiZn
dDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDs8YnI+
CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDsgVGhhbmtzPGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZn
dDsmZ3Q7IE5pY29sYSBMdW5naGk8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDs8YnI+CiZn
dDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDs8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDsgT24g
VHVlLCAxIE9jdCAyMDE5IGF0IDIyOjU0LCAmbHQ7PGEgaHJlZj0ibWFpbHRvOmxpbW9uLmFuaWJh
bEBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5saW1vbi5hbmliYWxAZ21haWwuY29tPC9hPiZn
dDsgd3JvdGU6PGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0Ozxicj4KJmd0OyAmZ3Q7
Jmd0OyZndDsmZ3Q7Jmd0OyZndDsgSGkgRHJlc2RvLDxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7
Jmd0OyZndDs8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDsmZ3Q7IEkgaGF2ZSBhIHBhdGNo
IHRoYXQgYWRkcyBzdXBwb3J0IGZvciBUZWxpdCBNRTkxMCBidXQgaXQgaXMgdXBvbiBPZm9ubyAx
LjMwLCBpIHBsYW4gdG8gc2VuZCBmb3IgcmV2aWV3Ljxicj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7
Jmd0OyZndDs8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDsmZ3Q7IDxhIGhyZWY9Imh0dHBz
Oi8vZ2l0aHViLmNvbS9hbGltb24vb2Zvbm8vY29tbWl0LzkyMDcxMmUxODRmZmFmMTE0M2U5Y2Ux
M2MzYmVjOGFjMWRlZWRhNWMiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBz
Oi8vZ2l0aHViLmNvbS9hbGltb24vb2Zvbm8vY29tbWl0LzkyMDcxMmUxODRmZmFmMTE0M2U5Y2Ux
M2MzYmVjOGFjMWRlZWRhNWM8L2E+PGJyPgomZ3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0Ozxi
cj4KJmd0OyAmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0OyZndDsgUmVnYXJkcyEsPGJyPgomZ3Q7ICZndDsm
Z3Q7Jmd0OyZndDsmZ3Q7Jmd0OyBBbmliYWw8YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDsm
Z3Q7IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fPGJyPgom
Z3Q7ICZndDsmZ3Q7Jmd0OyZndDsmZ3Q7Jmd0OyBvZm9ubyBtYWlsaW5nIGxpc3QgLS0gPGEgaHJl
Zj0ibWFpbHRvOm9mb25vQG9mb25vLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPm9mb25vQG9mb25vLm9y
ZzwvYT48YnI+CiZndDsgJmd0OyZndDsmZ3Q7Jmd0OyZndDsmZ3Q7IFRvIHVuc3Vic2NyaWJlIHNl
bmQgYW4gZW1haWwgdG8gPGEgaHJlZj0ibWFpbHRvOm9mb25vLWxlYXZlQG9mb25vLm9yZyIgdGFy
Z2V0PSJfYmxhbmsiPm9mb25vLWxlYXZlQG9mb25vLm9yZzwvYT48YnI+CjwvYmxvY2txdW90ZT48
L2Rpdj48L2Rpdj4K

--===============2174901693661462427==--

