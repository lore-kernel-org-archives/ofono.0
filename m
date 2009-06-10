Content-Type: multipart/mixed; boundary="===============1819921152233995466=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: MNC/MCC as string?
Date: Wed, 10 Jun 2009 11:15:19 -0500
Message-ID: <200906101115.20159.denkenz@gmail.com>
In-Reply-To: <5338cd9d9e632d7614da20e4277889b6@localhost>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1819921152233995466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Aki,

On Wednesday 10 June 2009 06:26:07 Aki Niemi wrote:
> Hi,
>
> Currently, the MNC and MCC values are of type short, which is a little
> problematic.
>
> The MNC code can either be 2 or 3 digits, and it would be quite natural to
> assume the logic is that 3 digits are used for codes > 99. However, this =
is
> not correct -- it depends on the MCC. It seems mostly American operators
> have 3 digit MNCs, whereas most of the rest of the world 2 digit MNCs. The
> implication is that 01 and 001 are not considered identical.

It doesn't seem this clear-cut.  E.g. according to my Neo on with T-Mobile =
US =

SIM:

AT+COPS?
+COPS: 0,0,"T-Mobile"
OK
AT+COPS=3D3,2
OK
AT+COPS?
+COPS: 0,2,"31026"
OK
AT+COPS=3D2
OK
+CREG: 0
AT+COPS=3D1,2,"31026"
OK
+CREG: 2
+CREG: 1,"99EC","1A11"

At least according to wikipedia the real MCC/MNC of T-Mobile is 310260.  Go =

figure.

>
> Nokia modems both send and receive MNC/MCC pairs as Binary Coded Decimal
> (BCD) strings. Any 2 digit MNC is padded with 0xF. Problem is, when listi=
ng
> operators, the conversion of MNC codes from BCD to short loses this
> information, and will result in manual network selection failing (BCD '00=
1'
> -> short '1' -> BCD '01F' !=3D BCD '001').
>
> Anyone opposed to changing the mnc and mcc code types from short to strin=
g?
>

I agree that this does seem to be an issue, so no problems in changing this=
.  =

Do you consider this an implementation issue only (e.g. APIs do not change)=
 or =

do you want to change the NetworkOperator attributes to a string as well?  =
If =

this is an implementation issue we can always adopt the Nokia convention of =

padding the MNC by 0xF on the right and leave them as a 'short'.

>
> Cheers,
> Aki
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

Regards,
-Denis

--===============1819921152233995466==--

