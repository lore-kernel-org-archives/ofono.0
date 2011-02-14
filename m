Content-Type: multipart/mixed; boundary="===============0595537169637772667=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: Re: [PATCH 1/1] gatserver: Add send raw data function
Date: Mon, 14 Feb 2011 17:32:46 +0100
Message-ID: <4D59592E.2090805@linux.intel.com>
In-Reply-To: <4D59571D.1090900@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0595537169637772667==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Denis,
The purpose was to be able to send long AT commands answers (like the =

AT+CGDCONT?) without allocating buffers but, after reconsidering the =

code it is not really needed as i can use the "g_at_server_send_info" =

for the same purpose ;)
So you can ignore this patch.
Thanks
Olivier

On 02/14/2011 05:23 PM, Denis Kenzior wrote:
> Hi Olivier,
>
>> @@ -112,6 +112,7 @@ void g_at_server_send_unsolicited(GAtServer *server,=
 const char *result);
>>    * responses.
>>    */
>>   void g_at_server_send_info(GAtServer *server, const char *line, gboole=
an last);
>> +void g_at_server_send_data(GAtServer *server, const char *format, ...);
>>
> What is the target use case you're thinking of for this one?
>
>>   #ifdef __cplusplus
>>   }
> Regards,
> -Denis


--===============0595537169637772667==--

