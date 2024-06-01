package cc

import (
	"time"
)


func GetDaysBetween(dateS1 string, dateS2 string, format string) (int, error) {
	date1, err := time.Parse(format, dateS1)
	if err != nil {
		return 0, err
	}

	date2, err := time.Parse(format, dateS2)
	if err != nil {
		return 0, err
	}

	return int(date1.Sub(date2).Hours() / 24), nil
}
