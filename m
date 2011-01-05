Content-Type: multipart/mixed; boundary="===============7295385867309887659=="
MIME-Version: 1.0
From: Rajesh.Nagaiah@elektrobit.com
Subject: RE: [PATCH v2, 3/7] cdma-sms: Add CDMA SMS Support
Date: Wed, 05 Jan 2011 14:34:17 -0800
Message-ID: <C681C76E0D5F1E4BB01DE79E0A80EEC702E65825@usrdes03.ebgroup.elektrobit.com>
In-Reply-To: <1292976149-15598-4-git-send-email-lei.2.yu@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7295385867309887659==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

HI Lei,

My comments inline =


> +
> +/* 3GPP2 C.S0015-B v2.0, Table 3.4-1 */ enum cdma_sms_tp_msg_type {
> +	CDMA_SMS_P2P =3D		0,
> +	CDMA_SMS_BCAST =3D	1,
> +	CDMA_SMS_ACK =3D		2
> +};

1.Coding style M11 not followed.
If enum type name is cdma_sms_tp_msg_type, then enum content
should be for eg, CDMA_SMS_TP_MSG_TYPE_XXX.
2. During initial discussions with Denis, he suggested to use
SMS_CDMA_XXX instead of CDMA_SMS_XXX. If he is OK with CDMA_SMS_XXX
usage I am OK with it as well.

> +/* 3GPP2 X.S0004-550-E, Section 2.256 */ =


As 3GPP2 X.S0004-550-E v4.0 Section 2.256 lists all the Teleservice
types, but we are listing here only the supported teleservice types.
So should we mention something like this ?

/* 3GPP2 X.S0004-550-E v4.0 Section 2.256.
Only supported by 3GPP2 C.S0015-B v2.0 Section 3.4.3.1 listed */

>enum cdma_sms_teleservice_id {
> +	TELESERVICE_CMT91 =3D	4096,
> +	TELESERVICE_WPT =3D	4097,
> +	TELESERVICE_WMT =3D	4098,
> +	TELESERVICE_VMN =3D	4099,
> +	TELESERVICE_WAP =3D	4100,
> +	TELESERVICE_WEMT =3D	4101,
> +	TELESERVICE_SCPT =3D	4102,
> +	TELESERVICE_CATPT =3D	4103
> +};

1. Coding style M11 not followed. =

Enum content should be CDMA_SMS_TELESERVICE_ID_XXX

2. There is no coding style of the values assigned, but
for such big numbers I think Hex represenation would be
better.

> +/* 3GPP2 C.S0005-E v2.0 Table 2.7.1.3.2.4-2 */ enum =

> +cdma_sms_digi_number_type {
> +	CDMA_SMS_NUM_TYPE_UNKNOWN =3D			0,
> +	CDMA_SMS_NUM_TYPE_INTERNATIONAL_NUMBER =3D	1,
> +	CDMA_SMS_NUM_TYPE_NATIONAL_NUMBER =3D		2,
> +	CDMA_SMS_NUM_TYPE_NETWORK_SPECIFIC_NUMBER =3D	3,
> +	CDMA_SMS_NUM_TYPE_SUBSCRIBER_NUMBER =3D		4,
> +	/* Reserved 5 */
> +	CDMA_SMS_NUM_TYPE_ABBREVIATED_NUMBER =3D		6
> +	/* Reserved 7 */
> +};

1.Coding style M11 not followed. =

2. _NUMBER suffix is not required.
3. Reserved values are defined in other enum declarations.
So to be inline with rest of ofono code we should define those
here as well

> +/* 3GPP2 C.S0015-B v2.0 Table 3.4.3.3-1 */ enum =

> +cdma_sms_data_network_number_type {
> +	CDMA_SMS_NETWORK_NUM_TYPE_UNKNOWN =3D		0,
> +	CDMA_SMS_NETWORK_TYPE_INTERNET_PROTOCOL =3D	1,
> +	CDMA_SMS_NETWORK_TYPE_INTERNET_EMAIL_ADDRESS =3D	2,
> +	/* All Other Values Reserved */
> +};

1.Coding style M11 not followed. =

2. Also some has CDMA_SMS_NETWORK_NUM_TYPE_XXX =

and some has CDMA_SMS_NETWORK_TYPE_XXX ?
3. Why do we need to have seperate cdma_sms_digi_number_type and
cdma_sms_data_network_number_type. Rather we can merge both of
it into one single enum cdma_sms_number_type, as we already know
whether its digit mode or number mode in seperate parameters.
For eg:
/* 3GPP2 C.S0005-E v2.0 Table 2.7.1.3.2.4-2 */ =

   and 3GPP2 C.S0015-B v2.0 Table 3.4.3.3-1 */ =

enum cdma_sms_number_type {
	CDMA_SMS_NUMBER_TYPE_UNKNOWN =3D 0,
	CDMA_SMS_NUMBER_TYPE_INTERNATIONAL_OR_IP =3D 1,
	CDMA_SMS_NUMBER_TYPE_NATIONAL_OR_INTERNET_EMAIL =3D 2,
	CDMA_SMS_NUMBER_TYPE_NETWORK_SPECIFIC =3D 3,
	CDMA_SMS_NUMBER_TYPE_SUBSCRIBER =3D 4,
	CDMA_SMS_NUMBER_TYPE_RESERVED_5 =3D 5,
	CDMA_SMS_NUMBER_TYPE_ABBREVIATED =3D 6
	CDMA_SMS_NUMBER_TYPE_RESERVED =3D 7,
};


> +/* 3GPP2 C.S0015-B v2.0 Table 4.5.1-1 */ enum cdma_sms_msg_type {
> +	CDMA_SMS_RESERVED =3D	0,
> +	CDMA_SMS_DELIVER =3D	1,
> +	CDMA_SMS_SUBMIT =3D	2,
> +	CDMA_SMS_CANCEL =3D	3,
> +	CDMA_SMS_DELIVER_ACK =3D	4,
> +	CDMA_SMS_USER_ACK =3D	5,
> +	CDMA_SMS_READ_ACK =3D	6,
> +};

1. Coding style M11 not followed. =

   It should be for eg, CDMA_SMS_MSG_TYPE_XXX
2. Why Deliver report and Submit report definitions missing ?
   Even though we dont support that feature yet in this patch,
   the definitions should be there.

For eg:
/* 3GPP2 C.S0015-B v2.0 Table 4.5.1-1 */ =

enum cdma_sms_msg_type {
	CDMA_SMS_MSG_TYPE_RESERVED =3D 0,
	CDMA_SMS_MSG_TYPE_DELIVER =3D 1,
	CDMA_SMS_MSG_TYPE_SUBMIT =3D 2,
	CDMA_SMS_MSG_TYPE_CANCEL =3D 3,
	CDMA_SMS_MSG_TYPE_DELIVER_ACK =3D 4,
	CDMA_SMS_MSG_TYPE_USER_ACK =3D 5,
	CDMA_SMS_MSG_TYPE_READ_ACK =3D 6,
	CDMA_SMS_MSG_TYPE_DELIVER_REPORT =3D 7,
	CDMA_SMS_MSG_TYPE_SUBMIT_REPORT =3D 8
};

> +/* C.R1001-G_v1.0 Table 9.1-1 */
> +enum cdma_sms_message_encoding {
> +	MSG_ENCODING_OCTET =3D			0,
> +	MSG_ENCODING_EXTENDED_PROTOCOL_MSG =3D	1,
> +	MSG_ENCODING_7BIT_ASCII =3D		2,
> +	MSG_ENCODING_IA5 =3D			3,
> +	MSG_ENCODING_UNICODE =3D			4,
> +	MSG_ENCODING_SHIFT_JIS =3D		5,
> +	MSG_ENCODING_KOREAN =3D			6,
> +	MSG_ENCODING_LATIN_HEBREW =3D		7,
> +	MSG_ENCODING_LATIN =3D			8,
> +	MSG_ENCODING_GSM_7BIT =3D			9,
> +	MSG_ENCODING_GSM_DATA_CODING =3D		10
> +};

1. Coding style M11 not followed. =

For eg:
/* 3GPP2 C.R1001-G v1.0 Table 9.1-1 */
enum cdma_sms_encoding_type {
	CDMA_SMS_ENCODING_TYPE_OCTECT_UNSPECIFIED =3D 0x0,
	CDMA_SMS_ENCODING_TYPE_EXTENDED_PROTOCOL_MESSAGE =3D 0x1,
	CDMA_SMS_ENCODING_TYPE_7BIT_ASCII =3D 0x2,
	CDMA_SMS_ENCODING_TYPE_IA5 =3D 0x3,
	CDMA_SMS_ENCODING_TYPE_UNICODE =3D 0x4,
	CDMA_SMS_ENCODING_TYPE_SHIFT_JIS =3D 0x5,
	CDMA_SMS_ENCODING_TYPE_KOREAN =3D 0x6,
	CDMA_SMS_ENCODING_TYPE_LATIN_HEBREW =3D 0x7,
	CDMA_SMS_ENCODING_TYPE_LATIN =3D 0x8,
	CDMA_SMS_ENCODING_TYPE_7BIT_GSM =3D 0x9,
	CDMA_SMS_ENCODING_TYPE_GSM_DCS =3D 0xA
};

> +/* 3GPP2 C.S0015-B v2.0 Table 3.4.3-1 */ enum cdma_sms_param_id {
> +	CDMA_SMS_PARAM_ID_TELESERVICE_IDENTIFIER  =3D	0x00,
> +	CDMA_SMS_PARAM_ID_SERVICE_CATEGORY =3D		0x01,
> +	CDMA_SMS_PARAM_ID_ORIGINATING_ADDRESS =3D		0x02,
> +	CDMA_SMS_PARAM_ID_ORIGINATING_SUBADDRESS =3D	0x03,
> +	CDMA_SMS_PARAM_ID_DESTINATION_ADDRESS =3D		0x04,
> +	CDMA_SMS_PARAM_ID_DESTINATION_SUBADDRESS =3D	0x05,
> +	CDMA_SMS_PARAM_ID_BEARER_REPLY_OPTION =3D		0x06,
> +	CDMA_SMS_PARAM_ID_CAUSE_CODE =3D			0x07,
> +	CDMA_SMS_PARAM_ID_BEARER_DATA =3D			0x08
> +};

Some enum values are in plain numbering, some are in hex. =

We should rather follow only hex.

> +/* 3GPP2 C.R1001-G Table 9.3.1-1 */
> +enum cdma_sms_service_category {
> +	SERVICE_CAT_EMERGENCY_BROADCAST =3D		1,
> +	SERVICE_CAT_ADMINISTRATIVE =3D			2,
> +	SERVICE_CAT_MAINTENANCE =3D			3,
> +	SERVICE_CAT_GENERALNEWSLOCAL =3D			4,
> +	SERVICE_CAT_GENERALNEWSREGIONAL =3D		5,
> +	SERVICE_CAT_GENERALNEWSNATIONAL =3D		6,
> +	SERVICE_CAT_GENERALNEWSINTERNATIONAL =3D		7,
> +	SERVICE_CAT_BUSINESSFINALNEWSLOCAL =3D		8,
> +	SERVICE_CAT_BUSINESSFINALNEWSREGIONAL =3D		9,
> +	SERVICE_CAT_BUSINESSFINALNEWSNATIONAL =3D		10,
> +	SERVICE_CAT_BUSINESSFINALNEWSINTNL =3D		11,
> +	SERVICE_CAT_SPORTSNEWSLOCAL =3D			12,
> +	SERVICE_CAT_SPORTSNEWSREGIONAL =3D		13,
> +	SERVICE_CAT_SPORTSNEWSNATIONAL =3D		14,
> +	SERVICE_CAT_SPORTSNEWSINTERNATIONAL =3D		15,
> +	SERVICE_CAT_ENTERTAINMENTNEWSLOCAL =3D		16,
> +	SERVICE_CAT_ENTERTAINMENTNEWSREGIONAL =3D		17,
> +	SERVICE_CAT_ENTERTAINMENTNEWSNATIONAL =3D		18,
> +	SERVICE_CAT_ENTERTAINMENTNEWSINTERNATIONAL =3D	19,
> +	SERVICE_CAT_ENTERTAINMENTNEWSLOCALWEATHER =3D	20,
> +	SERVICE_CAT_AREATRAFFICREPORTS =3D		21,
> +	SERVICE_CAT_LOCALAIRTPORTFLIGHTSCHEDULES =3D	22,
> +	SERVICE_CAT_RESTURANTS =3D			23,
> +	SERVICE_CAT_LODGINGS =3D				24,
> +	SERVICE_CAT_RETAILDIRECTORYADVERTISEMENTS =3D	25,
> +	SERVICE_CAT_ADVERTISEMENTS =3D			26,
> +	SERVICE_CAT_STOCKQUOTES =3D			27,
> +	SERVICE_CAT_EMPLOYMENTOPPORTUNITIES =3D		28,
> +	SERVICE_CAT_MEDICALHEALTHHOSPITALS =3D		29,
> +	SERVICE_CAT_TECHNOLOGYNEWS =3D			30,
> +	SERVICE_CAT_MULTICATEGORY =3D			31,
> +	SERVICE_CAT_CAPT =3D				32
> +};

1. Coding style M11 not followed. =

2. In SERVICE_CAT_XXX  the XXX part is completely unreadable.
   for eg:
   change _ENTERTAINMENTNEWSLOCALWEATHER
   to     _ENTERTAINMENT_NEWS_LOCAL_WEATHER
3. CMAS Broadcast Service Category Assignments definitions are missing
Include the following as well:
	CDMA_SMS_SERVICE_CATEGORY_PRESIDENTIAL_LEVEL_ALERT =3D 0x1000,
	CDMA_SMS_SERVICE_CATEGORY_EXTREME_THREAT_TO_LIFE_AND_PROPERTY =3D
0x1001,
	CDMA_SMS_SERVICE_CATEGORY_SEVERE_THREAT_TO_LIFE_AND_PROPERTY =3D
0x1002,
	CDMA_SMS_SERVICE_CATEGORY_AMBER_CHILD_ABDUCTION_EMERGENCY =3D
0x1003,
	CDMA_SMS_SERVICE_CATEGORY_CMAS_TEST_MESSAGE =3D 0x1004

> +enum cdma_sms_digit_mode {
> +	DTMF_4_BIT =3D	0,
> +	CODE_8_BIT =3D	1
> +};

1. Coding style M11 not followed.
2. CODE_8_BIT sounds odd, ASCII gives more meaning to it.
3. 3GPP2 reference missing.

change to:
/* 3GPP2 C.S0015-B v2.0 Section 3.4.3.3 */
enum cdma_sms_digit_mode_type {
	CDMA_SMS_DIGIT_MODE_TYPE_4BIT_DTMF =3D 0x0,
	CDMA_SMS_DIGIT_MODE_TYPE_8BIT_ASCII =3D 0x1
};

For digit mode type its defined as enum, but no enum defintion
for number mode type.

So add,

/* 3GPP2 C.S0015-B v2.0 Section 3.4.3.3 */
enum cdma_sms_number_mode_type {
	CDMA_SMS_NUMBER_MODE_TYPE_NON_DATA_NETWORK_ADDRESS =3D 0x0,
	CDMA_SMS_NUMBER_MODE_TYPE_DATA_NETWORK_ADDRESS =3D 0x1
}; =


> +
> +/* 3GPP2 C.S0015-B v2.0 Section 3.4.3.3 */ struct cdma_sms_address {
> +	enum cdma_sms_digit_mode digit_mode;
> +	guint8 number_mode;
> +	guint8 number_type;
> +	enum cdma_sms_numbering_plan number_plan;
> +	guint8 num_fields;
> +	char address[256];
> +};

1.Some members are defined as enums, some as guint8 eventhough they have
corresponding enum defintions. This will lead to explicit casts in the =

code later. So we should chnage that.
2. How did we get 256 as max address length ? =

Also avoid using magic numbers, rather declare them as constants.

> +/* 3GPP2 C.S0015-B v2.0 Section 4.5.2 */ struct cdma_sms_ud {
> +	enum cdma_sms_message_encoding msg_encoding;
> +	guint8  num_fields;
> +	guint8  chari[512];
> +};

1. Again how did we get 512 as max UD length ? =

Also avoid using magic numbers, rather declare them as constants.

BR,
Rajesh

--===============7295385867309887659==--

