Content-Type: multipart/mixed; boundary="===============3434057382498584972=="
MIME-Version: 1.0
From: Philippe De Swert <philippedeswert@gmail.com>
Subject: Re: [PATCH 2/4] plugins/ublox: Enable serial connection for an ublox
 modem
Date: Wed, 05 Jun 2019 15:37:45 +0300
Message-ID: <CAPsFW+SSg_1W84S2P-0krYNbqAkDkeRT3WmvQ=g39X=RN8wu3Q@mail.gmail.com>
In-Reply-To: <45d85a10-63ba-8b78-56ee-3ebf29f3fb51@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3434057382498584972==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 31/05/2019, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Philippe,
>
> Your indentation and coding style is all wrong here.

Well it was an RFC as in my cover letter I explained there were many
open issues I wondered about. Will clean it up when that  is clear
ofc.

>>   static void cfun_enable(gboolean ok, GAtResult *result, gpointer
>> user_data)
>>   {
>>   	struct ofono_modem *modem =3D user_data;
>> @@ -261,7 +314,7 @@ static int ublox_enable(struct ofono_modem *modem)
>>   	 * the 'Device' attribute instead...
>>   	 */
>>   	if (data->aux =3D=3D NULL) {
>> -		data->aux =3D open_device(modem, "Device", "Aux: ");
>> +		data->aux =3D open_serial_device(modem, "Device", "Aux: ");
>
> Tell me how you're driving a serial device without setting up a
> multiplexer.
>

Seems to work fine. Trying to set up a mux freezes the modem so... it
could however be I have misunderstood something though.

Regards,

Philippe

--===============3434057382498584972==--

