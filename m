Content-Type: multipart/mixed; boundary="===============6681362454765708548=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] plugins/ublox: Enable serial connection for an ublox
 modem
Date: Wed, 05 Jun 2019 09:55:45 -0500
Message-ID: <4544b439-20af-faf3-5f74-52d2172b2a37@gmail.com>
In-Reply-To: <CAPsFW+SSg_1W84S2P-0krYNbqAkDkeRT3WmvQ=g39X=RN8wu3Q@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6681362454765708548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 06/05/2019 07:37 AM, Philippe De Swert wrote:
> Hi Denis,
> =

> On 31/05/2019, Denis Kenzior <denkenz@gmail.com> wrote:
>> Hi Philippe,
>>
>> Your indentation and coding style is all wrong here.
> =

> Well it was an RFC as in my cover letter I explained there were many
> open issues I wondered about. Will clean it up when that  is clear
> ofc.

We (like other major projects, which are even more so) are very =

particular about coding style.  And it is good form (and to your =

advantage) to have your submissions follow that, regardless of whether =

they're RFC or not.

> =

>>>    static void cfun_enable(gboolean ok, GAtResult *result, gpointer
>>> user_data)
>>>    {
>>>    	struct ofono_modem *modem =3D user_data;
>>> @@ -261,7 +314,7 @@ static int ublox_enable(struct ofono_modem *modem)
>>>    	 * the 'Device' attribute instead...
>>>    	 */
>>>    	if (data->aux =3D=3D NULL) {
>>> -		data->aux =3D open_device(modem, "Device", "Aux: ");
>>> +		data->aux =3D open_serial_device(modem, "Device", "Aux: ");
>>
>> Tell me how you're driving a serial device without setting up a
>> multiplexer.
>>
> =

> Seems to work fine. Trying to set up a mux freezes the modem so... it
> could however be I have misunderstood something though.
> =


'Seems to work' isn't the right answer :)  In short: you need a =

multiplexer for a serial device with a single tty.

The reason for that is that once you enter data mode (PPP or whatever) =

on your serial port, all other AT command communication with the modem =

stops.  So you are not sending SMSs, receiving signal strength updates, etc.

So unless I'm missing something, the first step for you is to figure out =

how to get the multiplexer going first.  Since you intend to use PPP, =

there has to be at least two logical AT command ports for the device to =

be useful (one for PPP and one for AT commands).  More if you want to =

support multiple context activations, though with PPP that is unlikely.

Regards,
-Denis

--===============6681362454765708548==--

